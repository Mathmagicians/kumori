<template>
  <div>
  <b-btn size="small" v-b-modal="modalId">
    <v-icon name="pen" />
  </b-btn>
  <b-modal :id="modalId" :title="modalTitle">
    <b-form-group description="Keep the name concise." label="Usecase name">
      <b-form-input v-model.trim="name"></b-form-input>
    </b-form-group>
    <b-form-group description="Keep the description comprehensive." label="Usecase description">
      <b-form-textarea v-model="description" placeholder="Enter something" :rows="3" :max-rows="6">
      </b-form-textarea>
    </b-form-group>
    <b-form-group description="The scope for this usecase." label="Selected Scope">
      <b-form-select v-model="selected" :options="options" class="mb-3" />
    </b-form-group>
  </b-modal>

</div>
</template>

<script>
import Icon from 'vue-awesome/components/Icon'
import 'vue-awesome/icons/pen'
export default {
  name: 'edit',
  components: {
    'v-icon': Icon
  },
  props: ['id'],
  data() {
    return {
      name: this.id,
      description: '',
      options: [],
      selected: null
    }
  },
  computed: {
    modalTitle() {
      return `Edit "${this.name}"`;
    },
    modalId() {
      return `modal${this.id}`
    }
  }
}
</script>

<style scoped>
</style>
