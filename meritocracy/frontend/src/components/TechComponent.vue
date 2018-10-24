<template>
  <b-card no-body :id="tech.uid">
    <span
      slot="header"
      :v-b-toggle="accordionId">
			<b-button
        v-on:click="activate"
        variant="link"
        >
        {{tech.name}}
      </b-button>
			<life-cycle :status="tech.status" to="about" class="status-floater"></life-cycle>
		</span>

    <b-collapse
      :id="accordionId"
      accordion="tech"
       :visible="active?active:false">
       <loading v-if="this.loading">
        Loading details for tech component {{tech.uid}}
      </loading>
      <b-card-body v-else>
        <b-list-group flush>
          <b-list-group-item  v-if="techContent.tags">
            <p>Usecase Classification:</p>
             <h6> {{techContent.tags|stringify}}</h6>
          </b-list-group-item>
          <b-list-group-item v-if="techContent.description">
            <strong>Description:</strong>
            <b-row>
              <b-col cols="1">
                 <v-icon
                  name="clipboard"
                  color="grey"  />
              </b-col>
              <b-col cols="9">
                <p>{{techContent.description}}</p>
              </b-col>
              <b-col>
              </b-col>
            </b-row>
          </b-list-group-item>
          <b-list-group-item v-if="techContent.usecases && techContent.usecases.length>0">
             <strong>Usecases</strong>
             <b-badge>{{techContent.usecases.length}}</b-badge>:
            <b-row
              v-for="(uc, index) in techContent.usecases"
              class="justify-content-md-center">
              <b-col cols="1">
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
              </b-col>
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
          <b-list-group-item v-if="techContent.licenses">
            <strong>Licenses:</strong>
             <b-row
              v-for="license in techContent.licenses"
              class="justify-content-md-center">
              <b-col cols="1">
                <v-icon
                  name="clipboard"
                  color="grey" />
              </b-col>
              <b-col cols="9" v-if="license">
                <b-badge :variant="license.type === 'commercial'?'danger':'warning'">{{license.type}}</b-badge>
                {{license.description}}
                   <b-button
                  variant="link lg"
                  :href="license.ref">
                  {{license.ref}}
                </b-button>
              </b-col>
              <b-col/>
            </b-row>
          </b-list-group-item>
           <b-list-group-item v-if="techContent.links && techContent.links.length>0">
            <strong>Links:</strong>
            <b-row
              v-for="(link, index) in techContent.links"
              class="justify-content-md-center">
              <b-col cols="1">
                <v-icon
                  name="link"
                  color="grey" />
              </b-col>
              <b-col cols="9">
                <b-badge>{{link.type}}</b-badge>
                <b-button
                  variant="link lg"
                  :href="link.ref">
                  {{link.ref}}
                </b-button>
              </b-col>
              <b-col/>
            </b-row>
          </b-list-group-item>
          <b-list-group-item v-if="techContent.log">
            <strong>Change Log:</strong>
            <b-row
              v-for="(entry, index) in techContent.log"
              class="justify-content-md-center">
                <b-col cols="1">
                  <v-icon
                    v-if="index===0"
                    name="play"
                    color="green"/>
                  <v-icon
                    v-else
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
          <b-list-group-item v-if="techContent.debt">
            <strong>Technical debt:</strong>
            <b-row
              v-for="(entry, index) in techContent.debt"
              class="justify-content-md-center">
                <b-col cols="1">
                    <v-icon
                      v-if="entry.score >= 2"
                      name="fire"
                      color="orange"/>
                    <v-icon
                      v-else
                      name="fire"
                      color="grey"/>
                </b-col>
                <b-col cols="2">
                  <em>{{entry.date}}</em>
                </b-col>
                <b-col cols="7">
                    {{entry.description}}
              </b-col>
              <b-col>
                 by <em>{{entry.reporter}}</em>
              </b-col>
            </b-row>
          </b-list-group-item>
          <b-list-group-item>
            <strong>Comments:</strong>
            <b-row
              v-for="(entry, index) in techContent.comments"
              class="justify-content-md-center">
                <b-col cols="1">
                    <v-icon
                      name="comment"
                      color="grey"/>
                </b-col>
                <b-col cols="2">
                  <em>{{entry.date}}</em>
                </b-col>
                <b-col cols="7">
                    {{entry.description}}
              </b-col>
              <b-col>
                 <em>by {{entry.reporter}}</em>
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
import Loading from '../components/Loading.vue'
import filterMixin from '../mixins/filters.js'


export default {
  name: 'techComponent',
  data() {
    return {
      techContent: {},
      loading: false
    }
  },
  components: {
    LifeCycle, Loading
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
  created() {
    if(this.active) this.activate()
  },
  methods: {
    activate: function() {
      this.loadData()
      this.$router.push({name: 'component', params: {name: this.tech.name}})
    },
    edit: function(){
      this.$router.push({ name: 'edit', params: {name: this.tech.name}});
    },
    loadData() {
      this.loading = true
      this.$store.dispatch('fetchTechDetails', this.tech.uid)
        .then( details => { 
          this.techContent = details
          this.loading = false
          console.log(details)
        })
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

.btn {
  padding: .4rem .75rem;
}

.card {
  margin: 3px 0px;
}

.card-header {
  margin: 0px;
  padding: 0px;
}

</style>
