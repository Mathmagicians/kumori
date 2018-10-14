<template>
<div>
  <h1>Demo access to database</h1>
  <div v-if="tech.length === 0">No data</div>
  <div v-else>
    <h4>Found {{tech.length}} items:</h4>
      <h6>I alt {{page.total}}, page size: {{page.size}}, viser fra </h6>
   <b-button-toolbar>
      <b-button-group class="mx-1">
        <b-btn 
          v-for="(el,index) in pages" 
          :key="index" 
          @click="scrollToPage(index)"
          variant="link">
          {{pages[index].from}} - {{pages[index].to}} 
        </b-btn>
      </b-button-group>
    </b-button-toolbar>
    <b-list-group>
      <b-list-group-item 
        v-for="index in indexesForPage(page.activePageIndex)"
        :active="index===page.activeIndex"
        >
        {{index+1}}: {{tech[index].name}} | {{tech[index].status}}
        <b-badge class="mx-1"
          v-for="t in tech[index].tags">
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
          size: 10,
          from: 0,
          total: 101,
          activeIndex: 0,
          activeUid: null,
          activePage: {from:0, to:0},
          activePageIndex: 0
        }
      }
    },
    computed: {
      pages() {
        return this.pagesArray( this.page.total, this.page.size)
      }
    },
    created () {
      this.getHeaders(this.pages[0].from, this.pages[0].to)
    },
    methods: {
      /*fixme: unit test: input (42,10) out  [ { "from": 1, "to": 10 }, { "from": 11, "to": 20 }, { "from": 21, "to": 30 }, { "from": 31, "to": 40 }, { "from": 41, "to": 42 } ]
        for( 101,10)
         [ { "from": 1, "to": 10 }, { "from": 11, "to": 20 }, { "from": 21, "to": 30 }, { "from": 31, "to": 40 }, { "from": 41, "to": 50 }, { "from": 51, "to": 60 }, { "from": 61, "to": 70 }, { "from": 71, "to": 80 }, { "from": 81, "to": 90 }, { "from": 91, "to": 100 }, { "from": 101, "to": 101 } ]
          */
      pagesArray (total, size) {
        const totalPages = Math.ceil(total/size)
        return [...Array(totalPages).keys()].map( p => ({...this.shows(p,size, total)}))
      },
      indexesForPage( pi ){
        const start = this.pages[pi].from -1
        const end = this.pages[pi].to 
        return Array(end - start).fill().map((d, i) => i + start)
      },
      shows(pageIndex, pageSize, max){
        const pageStart = pageIndex*pageSize
        const pageEnd = pageStart+ pageSize < max ? pageStart+pageSize : max
        return { from: pageStart + 1, to: pageEnd }
      },
      scrollToPage(index){
        this.page.activePage = this.pages[index]
        this.page.activePageIndex = index
        this.getHeaders(this.page.activePage.from-1, this.page.activePage.to-1)
      },

      getHeaders: function(from=1, to=19) {
        // Prefer: count=exact
        // Range-Unit: items
        //Range: 0-19
        let config = {headers: {
          'Prefer': 'count=exact',
          'Range-Unit': 'w_components',
          'Range': `${from}-${to}`
        }}

        this.$http.get('http://0.0.0.0:3000/w_components?select=name,status,tags', config).then(response => {
          this.tech = response.body;
          console.log(response.headers['content-range'])
          console.log(response.headers)
          this.tech.forEach((t,i) => this.tech[i].name = `00${i} --- ${t.name}`)
         
           console.log(response.headers)
          console.log("printing headers")
          response.headers.forEach( (k,v) => console.log(`${k}:\t ${v}`))
          console.log(`We are interested in ${response.headers.get('content-range')} `)
          let range = response.headers.get('content-range')
          let rs = range.split('/')
          let total = rs[1]
          this.page.total = total
          let current = rs[0]
          let page = { from: rs[0].split('-')[0], to:rs[0].split('-')[1]}
          console.log( page)
       
        }, response => {
          this.tech = [];
        });
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
