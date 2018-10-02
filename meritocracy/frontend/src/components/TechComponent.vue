<template>
  <b-card no-body :id="tech.id">
    <span 
      slot="header" 
      :v-b-toggle="accordionId">
			<b-button 
        size="sm" 
        v-on:click="changeRoute" 
        variant="link"
        class="mb-2"
        >
        {{tech.name}}
      </b-button>
			<life-cycle :status="tech.status" to="about" class="status-floater"></life-cycle>
		</span>

    <b-collapse 
      :id="accordionId" 
      accordion="tech" 
       :visible="active?active:false">
      <b-card-body
        v-for="key in Object.keys(tech)"
        v-if="key!= 'name' && key !== 'status' && key !== 'uid' && tech[key]">
          <p><strong>{{key | capitalize }}</strong>: {{tech[key]}}</p>
      </b-card-body>
      <b-card-footer>
        <span >
					<b-button variant="outline-secondary sm" class="btn-round">
            <v-icon name="heart" scale="1"/></v-icon>
          </b-button>
          <b-button variant="outline-secondary sm" class="btn-round">
            <v-icon name="fire" scale="1"/></v-icon>
          </b-button>
          <b-button  variant="outline-secondary sm" class="btn-round">
            <v-icon name="comment" scale="1"/></v-icon>
          </b-button>
          <b-button  
            v-if="isEditOn"
            @click="edit"
            variant="outline-secondary sm" 
            class="btn-round">
            <v-icon name="pen" color="green" scale="1"/></v-icon>
          </b-button>
        </span>
      </b-card-footer>
    </b-collapse>
  </b-card>
</template>

<script>
import LifeCycle from '../components/LifeCycle.vue'
import filterMixin from '../mixins/filters.js'


export default {
  name: 'techComponent',
  components: {
    LifeCycle
  },
  props: {
    tech: {
      type: Object,
      required: true
    },
    active: {
      type: Boolean,
      default: false
    }
  },
  mixins: [
    filterMixin
  ],
  computed: {
    accordionId: function() {
      return 'accordion-' + this.tech.uid;
    },
    isEditOn() {
        return this.$store.getters.isEditOn;
      }
  },
  methods: {
    changeRoute: function() {
      this.$router.push('/components/' + this.tech.uid);
    },
    edit: function(){
      this.$router.push({ name: 'edit', params: { uid: this.tech.uid } });
    }
  }
}
</script>

<style scoped>
.status-floater {
  float: right;
}
</style>
