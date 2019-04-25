<template>
<div>
  <b-badge :variant='color'>{{ label }}</b-badge>
</div>
</template>

<script>
import Statuses from '@/api/Statuses.js'
export default {
  name: 'badge',
  components: {},
  props: {
    label: {
      default: () => {
        return 'To be decided'
      }
    }
  },
  data() {
    return {
      statuses: []
    }
  },
  computed: {
    color() {
      let s = this.statuses.filter(entry => {
        return entry.name === this.label;
      })[0]
      if (s !== undefined) {
        return s.variant
      }
      return 'Missing'
    }
  },
  mounted() {
    if (localStorage.getItem('kumoriStatuses') === null) {
      this.getStatuses()
    } else {
      this.statuses = JSON.parse(localStorage.getItem('kumoriStatuses'))
    }
  },
  watch: {},
  methods: {
    getStatuses() {
      Statuses.get(0, 10, ['id', 'name']).then(response => {
        this.statuses = response.data.map(entry => {
          let t = {}
          switch (entry.name) {
            case 'POC':
              t = {
                name: entry.name,
                variant: 'primary'
              };
              break;
            case 'Testing':
              t = {
                name: entry.name,
                variant: 'primary'
              };
              break;
            case 'Experiment':
              t = {
                name: entry.name,
                variant: 'primary'
              };
              break;
            case 'Deprecated':
              t = {
                name: entry.name,
                variant: 'danger'
              };
              break;
            case 'Do not use':
              t = {
                name: entry.name,
                variant: 'danger'
              };
              break;
            case 'To be decided':
              t = {
                name: entry.name,
                variant: 'secondary'
              };
              break;
            case 'Undecided':
              t = {
                name: entry.name,
                variant: 'secondary'
              };
              break;
            case 'Limited':
              t = {
                name: entry.name,
                variant: 'success'
              };
              break;
            case 'Default':
              t = {
                name: entry.name,
                variant: 'success'
              };
              break;
          }
          return t
        })
        localStorage.setItem('kumoriStatuses', JSON.stringify(this.statuses));
      }).catch(error => {
        console.log(error);
      })
    }
  }
}
</script>

<style scoped>
</style>
