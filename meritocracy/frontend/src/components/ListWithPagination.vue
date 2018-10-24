<template>
	<div ref="ListWithPagination">
	    <b-button-toolbar>
	      <b-button-group>
	        <b-btn
	        	id="left-rewind"
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
	          :key="i" 
	          v-if="isButtonPageVisible(i-1)"
	          @click="scrollToPage(i-1)"
	          :variant="buttonVariant(i-1)">
	            {{buttonName(i-1)}} 
	        </b-btn>
	      </b-button-group>
	      <b-button-group>
	        <b-btn
	           @click="scrollButtonBar(1)">
	          &rsaquo;
	        </b-btn>
	        <b-btn
	        	id="right-rewind"
	           	@click="scrollButtonsToEnd()">
	          	&raquo;
	        </b-btn>
	      </b-button-group>
		 </b-button-toolbar>
		 <div v-for="i in listSize">
		    <slot 
		    	:num="i" 
		    	:listSeq="index2ListOrdinal(i)" 
		    	:id="i"
		    	:isOn="isOnPage(i)">
		      	{{i}}: waiting for slot
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
				default: 11
			},
			buttonPanelSize: {
				type: Number,
				required: false,
				default: 9
			},
			listTotal: {
				type: Number,
				required: false,
				default: 15
			},
			activeOrdinal: {
				type: Number,
				required: false,
				default: 0
			}
		},
		data() {
	      return {
	        firstVisibleButton: 0,
	        activePageIndex: 0
	      }
    	},
    	created () {
    		this.activePageIndex = this.ordinal2pi(this.activeOrdinal)
			this.scrollToPage(this.activePageIndex)
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
				return i <= Math.min(this.firstVisibleButton+this.buttonPanelSize, this.numOfPages) && i >= Math.max(this.firstVisibleButton, 0)
			},
			buttonVariant( i ){
				return i === this.activePageIndex ? 'outline-success' : 'link'
			},
			scrollButtonBar(offset){
				let newfirstVisibleButton = this.firstVisibleButton + offset
				if( 0 <= newfirstVisibleButton && newfirstVisibleButton + this.buttonPanelSize < this.numOfPages )
				  this.firstVisibleButton = newfirstVisibleButton
				  this.scrollToPage(this.activePageIndex + offset)
			},
			scrollButtonsToStart(){
				this.firstVisibleButton = 0
				this.scrollToPage(0)
			},
			scrollButtonsToEnd(){
				this.firstVisibleButton = Math.max(0, this.numOfPages - this.buttonPanelSize)
				this.scrollToPage(this.numOfPages-1)
			},
	         index2ListOrdinal(i){
	        	//slots start counting from 1, ordinals in list from 0
	        	return this.pi2page(this.activePageIndex)+i-1
	        },
	        ordinal2pi(i){
	        	return i >= 0 ? Math.floor(i / this.listSize) : 0 
	        },
			pi2page(pageIndex) {
			return pageIndex*this.listSize
			},
			shows(pageIndex, size, max){
				const maxSize = Math.max(size, max)
				const from = this.pi2page(pageIndex) +1
				const to = Math.min( this.pi2page(pageIndex+1) , maxSize)
				return {from, to}
			},
			scrollToPage(index){
				if( 0 <= index && index < this.numOfPages){
					this.activePageIndex = index
				}
			},
			isOnPage(i){
				return this.index2ListOrdinal(i) < this.listTotal 
			}
	    }
	}
	
</script>