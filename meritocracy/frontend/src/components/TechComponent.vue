<template>
  <b-card no-body :id="tech.id">
    <span 
      slot="header" 
      :v-b-toggle="accordionId">
			<b-button 
        size="sm" 
        v-on:click="activate" 
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
      <b-card-body>
        <b-list-group flush>
          <b-list-group-item  v-if="tech.tags">
            <p>Usecase Classification:</p>
             <h6> {{tech.tags|stringify}}</h6>
          </b-list-group-item>
          <b-list-group-item v-if="tech.description">
            <strong>Description:</strong>
            <p>{{tech.description}}</p>
          </b-list-group-item>
          <b-list-group-item v-if="tech.usecases && tech.usecases.length>0">
             <strong>Usecases:</strong>
             <ul v-for="uc in tech.usecases" >
              <li>
                <p> {{uc.name}} <life-cycle :status="uc.status"/></p>
                <p> {{uc.description}}</p>
              </li>
            </ul>
          </b-list-group-item>
          <b-list-group-item v-if="tech.log">
            <strong>Change Log:</strong>
            <ul>
              <li v-for="entry in tech.log">
                {{entry.date}}: {{entry.description}}: <life-cycle :status="entry.status"/>
              </li>
            </ul>
          </b-list-group-item>
          <b-list-group-item v-if="tech.licenses">
            <strong>Licenses:</strong>
            <ul>
               <li v-for="license in tech.licenses">
                {{license}}
              </li>
            </ul>
          </b-list-group-item>
           <b-list-group-item v-if="tech.links">
            <strong>Links:</strong>
            <ul>
              <li v-for="link in tech.links">
                {{link}}
              </li>
            </ul>
          </b-list-group-item>
        </b-list-group>
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
    activate: function() {
      this.$router.push({name: 'component', params: { uid: this.tech.uid}})
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
