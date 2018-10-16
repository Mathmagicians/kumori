<template>
	<div ref="ListWithPagination">
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
		  <slot>
		  	Default content if you dont provide anything
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
		  </slot>
		  
		</div>

	</div>
	
</template>

<script>
	
	export default {
		name: 'ListWithPagination',
		props: {
			listSize: {
				type: Number,
				required: false,
				default: 20
			},
			buttonPanelSize: {
				type: Number,
				required: false,
				default: 9
			},
			list: {
				type: Array,
				required: false,
				default: () => [{name: 'test', status: 'Default'}]
			},
			listTotal: {
				type: Number,
				required: false,
				default: 0
			}
		},
		data() {
	      return {
	        tech: [],
	        page: {
	          loading: false,
	          firstVisible: 0,
	          activePageIndex: 0
	        }
	      }
    	},
    	created () {
			this.scrollToPage(this.page.activePageIndex)
		},
	    computed: {
	      numOfPages(){
	        return Math.ceil(this.listTotal/this.listSize)
	      }
	    },
	    methods: {
			buttonName( i ){
				let page = this.shows( i, this.listSize, this.listTotal)
				return `${page.from} - ${page.to}`
			},
			isButtonPageVisible( i ){
				return i <= Math.min(this.page.firstVisible+this.buttonPanelSize, this.numOfPages) && i >= Math.max(this.page.firstVisible, 0)
			},
			buttonVariant( i ){
				return i === this.page.activePageIndex ? 'outline-success' : 'link'
			},
			scrollButtonBar(offset){
				let newFirstVisible = this.page.firstVisible + offset
				if( 0 <= newFirstVisible && newFirstVisible + this.buttonPanelSize < this.numOfPages )
				  this.page.firstVisible = newFirstVisible
				  this.scrollToPage(this.page.activePageIndex + offset)
			},
			scrollButtonsToStart(){
				this.page.firstVisible = 0
				this.scrollToPage(0)
			},
			scrollButtonsToEnd(){
				this.page.firstVisible = Math.max(0, this.numOfPages - this.buttonPanelSize)
				this.scrollToPage(this.numOfPages-1)
			},
	       /*fixme: unit test: input (42,10) out  [ { "from": 1, "to": 10 }, { "from": 11, "to": 20 }, { "from": 21, "to": 30 }, { "from": 31, "to": 40 }, { "from": 41, "to": 42 } ]
	        for( 101,10)
	         [ { "from": 1, "to": 10 }, { "from": 11, "to": 20 }, { "from": 21, "to": 30 }, { "from": 31, "to": 40 }, { "from": 41, "to": 50 }, { "from": 51, "to": 60 }, { "from": 61, "to": 70 }, { "from": 71, "to": 80 }, { "from": 81, "to": 90 }, { "from": 91, "to": 100 }, { "from": 101, "to": 101 } ]
	          */
			pi2page(pageIndex) {
			return pageIndex*this.listSize
			},
			shows(index, size, max){
				const maxSize = Math.max(size, max)
				const from = this.pi2page(index) +1
				const to = Math.min( this.pi2page(index+1) , maxSize)
				return {from, to}
			},
			scrollToPage(index){
				if( 0 <= index && index < this.numOfPages){
					this.page.loading = true
					this.page.activePageIndex = index
					let newPageIndexes = this.shows(index, this.page.size, this.listTotal)
					//this.getHeaders(newPageIndexes.from-1, newPageIndexes.to-1)
					console.log("todo - headers not implemented")
					//fixme - remove
					this.page.loading =false
				}
				//this.tech.forEach((t,i) => this.tech[i].name = `00${i} --- ${t.name}`)
			},
	    }
	}
	
</script>