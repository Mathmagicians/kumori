<template>
<div>
  <h1>Projects</h1>
  <list-with-pagination ref="pagination" :list-size="projects.length" v-bind:list-total="projects.length" v-bind:activeOrdinal="0" :button-panel-size="7">
    <project slot-scope="props" v-if="props.isOn" :project="projects[props.listSeq]">
    </project>
  </list-with-pagination>
</div>
</template>

<script>
import Project from '../components/Project.vue'
import Projects from '../api/Projects.js'
import ListWithPagination from '../components/ListWithPagination.vue'

export default {
  name: 'projects',
  components: {
    'v-icon': Icon,
    'project': Project,
  },
  data() {
    return {
      loading: false,
      projects: Projects.list()
    }
  }
}
</script>

<style scoped>
</style>
