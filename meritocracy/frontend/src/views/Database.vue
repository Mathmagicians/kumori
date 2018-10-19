<template>
<div>
  <h1>Demo list with pagination</h1>
  <list-with-pagination
    :list-total="7"
    :list-size="2"
    :button-panel-size="2">
  </list-with-pagination>
  <h1>Demo access to database</h1>
  <div v-if="page.loading">Loading data ... </div>
  <div v-else>
        <b-button-toolbar>
          <b-button-group>
            <b-btn
              @click="scrollButtonsToStart()">
              &laquo;
            </b-btn>
            <b-btn
              @click="scrollButtonBar(-1)">
              &lsaquo;
            </b-btn>
          </b-button-group>
          <b-button-group class="mx-1">
            <b-btn 
              class="mx-1 pagination"
              v-for="i in numOfPages" 
              v-if="isButtonPageVisible(i-1)"
              :key="i" 
              @click="scrollToPage(i-1)"
              :variant="buttonVariant(i-1)">
                {{ buttonName(i-1)}} 
            </b-btn>
          </b-button-group>
          <b-button-group>
            <b-btn
               @click="scrollButtonBar(1)">
              &rsaquo;
            </b-btn>
            <b-btn
               @click="scrollButtonsToEnd()">
              &raquo;
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

  import ListWithPagination from '../components/ListWithPagination.vue'

  export default {
    name: 'database',
    data() {
      return {
        tech: [],
        page: {
          loading: false,
          size: 4,
          visible: 7,
          firstVisible: 0,
          total: 0,
          activePageIndex: 0
        }
      }
    },
    components: {ListWithPagination},
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
      isButtonPageVisible( i ){
        return i <= Math.min(this.page.firstVisible+this.page.visible, this.numOfPages) && i >= Math.max(this.page.firstVisible, 0)
      },
      buttonVariant( i ){
        return i === this.page.activePageIndex ? 'outline-success' : 'link'
      },
      scrollButtonBar(offset){
        let newFirstVisible = this.page.firstVisible + offset
        if( 0 <= newFirstVisible && newFirstVisible + this.page.visible < this.numOfPages )
          this.page.firstVisible = newFirstVisible
          this.scrollToPage(this.page.activePageIndex + offset)
      },
      scrollButtonsToStart(){
        this.page.firstVisible = 0
        this.scrollToPage(0)
      },
      scrollButtonsToEnd(){
        this.page.firstVisible = Math.max(0, this.numOfPages - this.page.visible)
        this.scrollToPage(this.numOfPages-1)
      },
       /*fixme: unit test: input (42,10) out  [ { "from": 1, "to": 10 }, { "from": 11, "to": 20 }, { "from": 21, "to": 30 }, { "from": 31, "to": 40 }, { "from": 41, "to": 42 } ]
        for( 101,10)
         [ { "from": 1, "to": 10 }, { "from": 11, "to": 20 }, { "from": 21, "to": 30 }, { "from": 31, "to": 40 }, { "from": 41, "to": 50 }, { "from": 51, "to": 60 }, { "from": 61, "to": 70 }, { "from": 71, "to": 80 }, { "from": 81, "to": 90 }, { "from": 91, "to": 100 }, { "from": 101, "to": 101 } ]
          */
      pi2page(pageIndex) {
        return pageIndex*this.page.size
      },
      shows(index, size, max){
        const maxSize = Math.max(size, max)
        const from = this.pi2page(index) +1
        const to = Math.min( this.pi2page(index+1) , maxSize)
        return {from, to}
      },
      scrollToPage(index){
        if( 0 <= index && index < this.numOfPages)
        this.page.loading = true
        this.page.activePageIndex = index
        let newPageIndexes = this.shows(index, this.page.size, this.page.total)
        this.getHeaders(newPageIndexes.from-1, newPageIndexes.to-1)
        //this.tech.forEach((t,i) => this.tech[i].name = `00${i} --- ${t.name}`)
      },

      getHeaders: function(from=0, to=10) {
        // Prefer: count=exact
        // Range-Unit: items
        //Range: 0-10
        let config = {headers: {
          'Prefer': 'count=exact',
          'Range-Unit': 'w_components',
          'Range': `${from}-${to}`
        }}

        let headersResponse = {headers: [], total: 0}

        this.$http.get('http://0.0.0.0:3000/w_components?select=name,status,tags', config)
        .then(response => {
          console.log(`We are interested in ${response.headers.get('content-range')} `)
          let range = response.headers.get('content-range')
          let rs = range.split('/')
          let total = rs[1]
          this.page.total = Number(total)
          let current = rs[0]
          let page = { from: rs[0].split('-')[0], to:rs[0].split('-')[1]}
          this.tech = response.body
          this.page.loading = false
        }, response => {
          return headersResponse
        })
      }
    }
  }
</script>

<style scoped>
.pagination {
  min-width: 3rem;
}
</style>
