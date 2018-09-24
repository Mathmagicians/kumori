<template>
  <b-card no-body :id="id">
    <span 
      slot="header" 
      :v-b-toggle="accordionId"
      @click="changeRoute">
			<b-button 
        size="sm" 
        v-on:click="changeRoute" 
        variant="link">
        {{tech.name}}
      </b-button>
			<life-cycle :status="tech.status" to="about"></life-cycle>
		</span>

    <b-collapse 
      :id="accordionId" 
      accordion="tech" 
      v-on:show="changeRoute" 
      :visible="active?active:false">
      <div>
        <div 
          v-for="key in Object.keys(tech)"
          class="card-text">
           <div v-if="key!= 'name' && key !== 'status' && key !== 'uid'">
              <h6>{{key | capitalize }}</h6>
              <p>{{tech[key]}}</p>
          </div >
          
        </div>
        <div slot="footer" class="card-footer">
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
        </span>
      </div>
    	</div>
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
    id: {
      type: String,
      required: true
    },
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
    }
  },
  methods: {
    changeRoute: function() {
      this.$router.push('/components/' + this.tech.uid);
    }
  }
}
</script>

<style scoped>
.test {
  background-color: red;
}
</style>
