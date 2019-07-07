<template>
<b-modal ref="map_taxononmy" :title="title" @ok="save" @cancel="cancel">
  {{usecase.id}} {{usecase.name}}
</b-modal>
</template>

<script>
import {
  EventBus
} from "@/api/event-bus.js";
export default {
  name: "map-taxonomy",
  data() {
    return {
      usecase: {
        id: undefined,
        name: undefined,
        description: undefined
      }
    }
  },
  mounted() {
    EventBus.$on("show-create-usecase-taxonomy-map-dialog", usecase => {
      this.usecase = usecase
      this.$refs.map_taxononmy.show();
    });
  },
  computed: {
    title() {
      return `Map usecase "${this.usecase.name}" to taxonomies(s)`
    }
  },
  methods: {
    save() {
      console.log('Not implemented')
    },
    cancel() {
      EventBus.$emit("update-usecase-list");
    }
  }
};
</script>

<style scoped></style>
