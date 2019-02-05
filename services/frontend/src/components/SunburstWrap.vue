<template>
<div class="test">
  <sunburst ref="sunburst" :data="tree" v-on:clickNode="nodeClicked" class="sunburst">

    <!-- Add behaviors -->
    <template slot-scope="{ nodes, actions }">
      <highlightOnHover :nodes="nodes" :actions="actions" />
      <zoomOnClick :nodes="nodes" :actions="actions" />
    </template>

    <!-- Add information to be displayed on top the graph -->

    <nodeInfoDisplayer slot="legend" id="info" slot-scope="{ nodes }" :current="nodes.mouseOver" :root="nodes.root" description="of usecases" />

    <!-- Add bottom legend -->

    <breadcrumbTrail class="small-text" id="breadcrumbs" :width="700" slot="top" slot-scope="{ nodes,colorGetter,width}" :current="nodes.mouseOver" :root="nodes.root" :colorGetter="colorGetter" :from="nodes.clicked" :item-width="110" :item-height="40"
      :spacing="2" />
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
import 'vue-d3-sunburst/dist/vue-d3-sunburst.css'

export default {
  name: 'SunburstWrap',
  components: {
    breadcrumbTrail,
    highlightOnHover,
    nodeInfoDisplayer,
    sunburst,
    zoomOnClick
  },
  props: [
    'tree'
  ],
  methods: {
    nodeClicked(obj) {
      this.$emit('nodeClicked', {
        clicked: obj.node.data.name,
        trail: this.findTrail(obj.node)
      });
    },
    findTrail(node) {
      let trail = [];
      let myNode = node;
      while (myNode.parent) {
        trail.unshift(myNode.data.name);
        myNode = myNode.parent;
      }
      return trail;
    },
    resetPath() {
      this.$refs.sunburst.zoomToNode(this.$refs.sunburst.graphNodes.root)
    }
  }
}
</script>

<style scoped>
.small-text {
  font-size: 0.65em;
  word-wrap: break-word;
}

.sunburst {
  width: 700px;
  height: 700px;
  position: relative;
}

.father {
  position: relative;
  width: 100%;
  height: 100%;
  display: flex;
  justify-content: center;
}
</style>
