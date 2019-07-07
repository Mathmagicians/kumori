<template>
<b-modal ref="map_component" :title="title" @ok="save" @cancel="cancel">
  {{usecase.id}} {{usecase.name}}
</b-modal>
</template>

<script>
import {
  EventBus
} from "@/api/event-bus.js";
import Unit from "@/api/Unit";
export default {
  name: "map-component",
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
    EventBus.$on("show-create-usecase-component-map-dialog", usecase => {
      this.usecase = usecase
      this.$refs.map_component.show();
    });
  },
  computed: {
    title() {
      return `Map usecase "${this.usecase.name}" to component(s)`
    }
  },
  methods: {
    save() {
      console.log('Not implemented')
      new Unit().addUsecase(1,1,1,'test')
    },
    cancel() {
      EventBus.$emit("update-usecase-list");
    }
  }
};
</script>

<style scoped></style>
