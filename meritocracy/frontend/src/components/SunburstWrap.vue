<template>
	<sunburst :data="tree">

		<!-- Add behaviors -->
		<template slot-scope="{ nodes, actions }">
		<highlightOnHover :nodes="nodes" :actions="actions" />
		<zoomOnClick :nodes="nodes" :actions="actions" />
		</template>

		<!-- Add information to be displayed on top the graph -->
		<nodeInfoDisplayer slot="legend" id="info" slot-scope="{ nodes }" :current="nodes.mouseOver" :root="nodes.root" />

		<!-- Add bottom legend -->
		<breadcrumbTrail id="breadcrumbs" slot="top"  slot-scope="{ nodes, colorGetter, width }" :current="nodes.mouseOver" :root="nodes.root" :colorGetter="colorGetter" :from="nodes.clicked" />

	</sunburst>
</template>

<script>

	import {
	  breadcrumbTrail,
	  highlightOnHover,
	  nodeInfoDisplayer,
	  sunburst,
	  zoomOnClick
	} from 'vue-d3-sunburst'
	
	export default {
		name: "SunburstWrap",		
		components: {
			breadcrumbTrail,
		    highlightOnHover,
		    nodeInfoDisplayer,
		    sunburst,
		    zoomOnClick
		},
		props: [
			'tree'
		]
    }


</script>