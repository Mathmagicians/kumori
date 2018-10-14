<template>
<div>
  <h1>Demo access to database</h1>
  <div v-if="page.loading">Loading data ... </div>
  <div v-else>
    <h4>Found {{tech.length}} items:</h4>
      <h6>I alt {{page.total}}, page size: {{page.size}}, viser page {{page.activePageIndex}} </h6>
   
      <b-button-toolbar>
        <b-button-group class="mx-1">
          <b-btn 
            v-for="i in numOfPages" 
            :key="i" 
            @click="scrollToPage(i-1)"
            variant="link">
             {{i-1}}: {{ buttonName(i-1)}} 
          </b-btn>
        </b-button-group>
    </b-button-toolbar>

      <b-list-group>
        <b-list-group-item 
          v-for="(t, index) in tech" 
          :active="index===page.activeIndex"
          >
          {{pi2page(page.activePageIndex)+index+1}}: {{t.name}} | {{t.status}}
          <b-badge class="mx-1"
            v-for="t in t.tags">
            {{t}}
          </b-badge>
          <v-icon v-if="page.activeIndex=== index" name="clipboard" scale="2" color="orange"/>
        </b-list-group-item>
  </b-list-group>
  </div>
</div>
</template>

<script>
  export default {
    name: 'database',
    data() {
      return {
        tech: [],
        page: {
          loading: false,
          size: 10,
          total: 0,
          activePageIndex: 0
        }
      }
    },

    computed: {
      numOfPages(){
        return Math.ceil(this.page.total/this.page.size)
      }
    },

    created () {
      this.scrollToPage(this.page.activePageIndex)
    },


    methods: {
       buttonName( i ){
        let page = this.shows( i, this.page.size, this.page.total)
        return `${page.from} - ${page.to}`
      },
       /*fixme: unit test: input (42,10) out  [ { "from": 1, "to": 10 }, { "from": 11, "to": 20 }, { "from": 21, "to": 30 }, { "from": 31, "to": 40 }, { "from": 41, "to": 42 } ]
        for( 101,10)
         [ { "from": 1, "to": 10 }, { "from": 11, "to": 20 }, { "from": 21, "to": 30 }, { "from": 31, "to": 40 }, { "from": 41, "to": 50 }, { "from": 51, "to": 60 }, { "from": 61, "to": 70 }, { "from": 71, "to": 80 }, { "from": 81, "to": 90 }, { "from": 91, "to": 100 }, { "from": 101, "to": 101 } ]
          */
      pi2page(pageIndex) {
        return pageIndex*this.page.size
      },
      shows(index, size, max){
        console.log(`>>>shows>>>: index ${index}, size ${size}, max ${max}`)
        const maxSize = Math.max(size, max)
        const from = this.pi2page(index) +1
        const to = Math.min( this.pi2page(index+1) , maxSize)
        const indexes = {from, to}
        console.log(`>>> shows >>> from : ${indexes.from}, to: ${indexes.to}`)
        return indexes
      },
      scrollToPage(index){
        this.page.loading = true
        this.page.activePageIndex = index
        console.log(`>>> scroll to page>>> ${index}`)
        let newPageIndexes = this.shows(index, this.page.size, this.page.total)
        this.getHeaders(newPageIndexes.from-1, newPageIndexes.to-1)
        //this.tech.forEach((t,i) => this.tech[i].name = `00${i} --- ${t.name}`)
      },

      getHeaders: function(from=0, to=10) {
        // Prefer: count=exact
        // Range-Unit: items
        //Range: 0-19
        let config = {headers: {
          'Prefer': 'count=exact',
          'Range-Unit': 'w_components',
          'Range': `${from}-${to}`
        }}

        let headersResponse = {headers: [], total: 0}

        console.log(`>>> getHeaders >>> from ${from}, to ${to}`)

        this.$http.get('http://0.0.0.0:3000/w_components?select=name,status,tags', config)
        .then(response => {
          console.log(`We are interested in ${response.headers.get('content-range')} `)
          let range = response.headers.get('content-range')
          let rs = range.split('/')
          let total = rs[1]
          this.page.total = Number(total)
          let current = rs[0]
          let page = { from: rs[0].split('-')[0], to:rs[0].split('-')[1]}
          console.log( page)
          console.log(response.body)
          this.tech = response.body
          this.page.loading = false
        }, response => {
          return headersResponse
        })
      },
      getDetails () {
        // 'content-range'
        this.$http.get('http://0.0.0.0:3000/w_components?select=name,status').then(response => {
          this.tech = response.body;

        }, response => {
          this.tech = [];
        });
      },
      fetchTaxonomy () {
      let config = {headers: {'Accept': 'application/vnd.pgrst.object+json'}}

       return axios
        .get(`${BASE_URL}w_taxonomy`, config)
        .then(response => response.data)
        .catch((error) => onError(error))
      }
    }
  }
</script>
