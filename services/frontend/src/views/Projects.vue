<template>
<div>
  <b-alert show variant="secondary">
    your projects
  </b-alert>
  <b-alert show variant="warning" v-if="loading">Loading Kumori services …
    <v-icon name="spinner" scale="2" spin />
  </b-alert>
  <b-list-group v-else class="components">
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
  name: 'Project Awesome',
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
  name: 'Project 2',
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
import Icon from 'vue-awesome/components/Icon'
import 'vue-awesome/icons/keyboard'
import 'vue-awesome/icons/spinner'
import Project from '@/components/Project'
export default {
  name: 'projects',
  components: {
    'v-icon': Icon,
    'project': Project,
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
