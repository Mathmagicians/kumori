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
      Kumori is happily governing <b>{{services.length}}</b> services.
    </b-alert>

    <b-list-group-item v-for="project in projects" :key="project.name" class="tech-component">
      <project :data="project"/>
    </b-list-group-item>
  </b-list-group>
</div>
</template>

<script>
let data = [{
  name: 'Project 1',
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
  name: 'services',
  components: {
    'v-icon': Icon,
    'project': Project,
  },
  data() {
    return {
      loading: false,
      projects: data
    }
  },
  computed: {
    services() {
      return this.$store.state.services
    }
  },
  created() {
    this.loading = true
    this.$store.dispatch('fetchServices')
      .then(services => {
        this.loading = false
      })
  }
}
</script>

<style scoped>
</style>
