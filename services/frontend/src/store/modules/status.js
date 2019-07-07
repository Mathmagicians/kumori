import Status from "@/api/Status";
const state = {
  list: [],
  selectOptions: [],
  selected: [],
  error: undefined
}

const getters = {
  list: state => state.list,
  selectOptions: state => state.selectOptions,
  selected: state => state.selected
}

const actions = {
  list({
    commit,
    state
  }) {
    if (state.list.length === 0) {
      new Status().get(0, 10, ["id", "name"], [], [])
        .then(response => {
          commit('setList', response.data)
          commit('setSelectOptions', response.data.map(entry => {
            return {
              text: entry.name,
              value: entry.id
            }
          }))
        }).catch(error => {
          commit('setError', error)
        })
    }
  }
}

const mutations = {
  setSelected(state, selected) {
    state.selected = selected;
  },
  setList(state, list) {
    state.list = list;
  },
  setSelectOptions(state, list) {
    state.selectOptions = list;
  },
  setError(state, error) {
    state.error = error;
  }
}

export default {
  namespaced: true,
  state,
  getters,
  actions,
  mutations
}
