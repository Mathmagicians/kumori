<template>
	<div>
	Hello world from sunburst!
	<sunburst :data="tree">

		<!-- Add behaviors -->
		<template slot-scope="{ nodes, actions }">
		<highlightOnHover :nodes="nodes" :actions="actions" />
		<zoomOnClick :nodes="nodes" :actions="actions" />
		</template>

		<!-- Add information to be displayed on top the graph -->
		<nodeInfoDisplayer slot="top" slot-scope="{ nodes }" :current="nodes.mouseOver" :root="nodes.root" description="of visits begin with this sequence of pages" />

		<!-- Add bottom legend -->
		<breadcrumbTrail slot="legend" slot-scope="{ nodes, colorGetter, width }" :current="nodes.mouseOver" :root="nodes.root" :colorGetter="colorGetter" :from="nodes.clicked" :width="width" />

	</sunburst>
</div>
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
		data() {
    return { 
      tree:  {
      "name": "flare",
        "children": [
          {
            "name": "analytics",
            "children": [
              {
                "name": "cluster",
                "children": [
                  { "name": "AgglomerativeCluster", "size": 3938 },
                  { "name": "CommunityStructure", "size": 3812 },
                  { "name": "HierarchicalCluster", "size": 6714 },
                  { "name": "MergeEdge", "size": 743 }
                ]
              },
              {
                "name": "graph",
                "children": [
                  { "name": "BetweennessCentrality", "size": 3534 },
                  { "name": "LinkDistance", "size": 5731 },
                  { "name": "MaxFlowMinCut", "size": 7840 },
                  { "name": "ShortestPaths", "size": 5914 },
                  { "name": "SpanningTree", "size": 3416 }
                ]
              },
              {
                "name": "optimization",
                "children": [
                  { "name": "AspectRatioBanker", "size": 7074 }
                ]
              }
            ]
          }
        ]
      }
    }
  }

	}

</script>