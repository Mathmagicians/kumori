<template>
<split title="usecases">
  <template v-slot:left>
    <list-usecase />
  </template>
  <template v-slot:right>
    <edit-usecase />
    <show-usecase />
    <add-usecase />
    <remove-usecase />
    <map-component />
    <map-taxonomy />
  </template>
</split>
</template>

<script>
import {
  mapGetters
} from 'vuex'
import Split from "@/components/Split";
import ListUsecase from "@/components/usecase/List";
import ShowUsecase from "@/components/usecase/Show";
import AddUsecase from "@/components/usecase/Add";
import EditUsecase from "@/components/usecase/Edit";
import RemoveUsecase from "@/components/usecase/Remove";
import MapComponent from "@/components/usecase/MapComponent";
import MapTaxonomy from "@/components/usecase/MapTaxonomy";

export default {
  components: {
    "split": Split,
    "list-usecase": ListUsecase,
    "edit-usecase": EditUsecase,
    "show-usecase": ShowUsecase,
    "add-usecase": AddUsecase,
    "remove-usecase": RemoveUsecase,
    "map-component": MapComponent,
    "map-taxonomy": MapTaxonomy
  }
};
</script>

<style scoped></style>
