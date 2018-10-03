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
            <b-row 
              v-for="(uc, index) in tech.usecases" 
              class="justify-content-md-center">
              <b-col><b-button 
                    class="btn-round" 
                    variant="light">
                      <v-icon 
                        v-if="index===0"
                        scale="1"
                        name="toolbox" 
                        color="green" />
                      <v-icon 
                        v-else
                        scale="1"
                        name="toolbox" 
                        color="grey" />
                  </b-button></b-col>
              <b-col cols="9">
                <b-badge 
                  v-if="index===0"
                  variant="success">Primary</b-badge>
                 <b-badge 
                  v-else
                  variant="secondary">Secondary</b-badge>
                <b> {{uc.name}}</b>
                <p> {{uc.description}}</p>
                <p v-if="uc.scope"><b>Scope:</b> {{uc.scope}}</p>
              </b-col>
              <b-col>
                 <life-cycle :status="uc.status"/>
              </b-col>
          </b-row>
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
          <b-list-group-item v-if="tech.log">
            <strong>Change Log:</strong>
            <b-row 
              v-for="(entry, index) in tech.log"
              class="justify-content-md-center">
                <b-col>
                    <v-icon 
                      v-if="index===1"
                      name="play" 
                      scale="0.5"
                      color="green"/>
                    <v-icon 
                      v-else
                      scale="0.5"
                      name="play" 
                      color="grey"/>
                </b-col>
                <b-col cols="2">
                  <em>{{entry.date}}</em>
                </b-col>
                <b-col cols="7">
                    {{entry.description}}
              </b-col>
              <b-col>
                <life-cycle :status="entry.status"/>
              </b-col>
            </b-row>
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
  .usecase{
    list-style-type:none;
  }

.btn-round {
  border-radius: 50px;
}

</style>
