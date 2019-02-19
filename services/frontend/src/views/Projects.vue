<template>
<div>

    <b-alert show variant="secondary">
      your projects
    </b-alert>

    <list-with-pagination ref="pagination" :list-size="projects.length" v-bind:list-total="projects.length" v-bind:activeOrdinal="0" :button-panel-size="7">
      <project slot-scope="props"  v-if="props.isOn" :project="projects[props.listSeq]">
      </project>
    </list-with-pagination>

  </div>
</template>

<script>
let data = [{
  name: 'Project Suspicious',
  status: {
    value: 1,
    trend: 1,
    timestamp: '2018-08-21:00:00:00'
  },
  history: [{
    value: 1,
    trend: 1,
    timestamp: '2018-08-01:00:00:00'
  }, {
    value: 1,
    trend: 1,
    timestamp: '2018-07-21:00:00:00'
  }, {
    value: 1,
    trend: 1,
    timestamp: '2018-06-01:00:00:00'
  }]
}, {
  name: 'Project Awesome',
  status: {
    value: 5,
    trend: -1,
    timestamp: '2018-08-21:00:00:00'
  },
  history: [{
    value: 1,
    trend: 1,
    timestamp: '2018-08-01:00:00:00'
  }, {
    value: 1,
    trend: 1,
    timestamp: '2018-07-21:00:00:00'
  }, {
    value: 1,
    trend: 1,
    timestamp: '2018-06-01:00:00:00'
  }]
}]

import Project from '../components/Project.vue'
import ListWithPagination from '../components/ListWithPagination.vue'

export default {
  name: 'projects',
  components: {
    'project': Project,
    'list-with-pagination': ListWithPagination
  },
  data() {
    return {
      loading: false,
      projects: data
    }
  }
}
</script>

<style scoped>
</style>
