const state = {
  updated: undefined
}

const getters = {
    updated: state => state.updated,
}

const actions = {
}

const mutations = {
  updated(state) {
    state.updated = Math.random();
  },
}

export default {
  namespaced: true,
  state,
  getters,
  actions,
  mutations
}
