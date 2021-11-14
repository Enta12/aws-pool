<template>
    <v-container fill-height fluid>
        <v-col cols="12" md="12" class="justify-center">
          <WorkingTimes/>
        </v-col>
    </v-container>
</template>

<script>
import WorkingTimes from "./WorkingTimes";

export default {
  name: "User",
  components: {
    WorkingTimes
  }
}
</script>

<style scoped>

</style>