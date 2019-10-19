import Taxonomy from "@/api/Taxonomy";
const state = {
  list: [],
  level1: [],
  level2: [],
  level3: [],
  level4: [],
  selected: [],
  selected1: [],
  selected2: [],
  selected3: [],
  selected4: [],
  error: undefined
}

const getters = {
  list: state => state.list,
  level1: state => {
    return state.level1.map(entry => {
      let disabled = false
      if (state.selected1.length != 0 && state.selected2.length != 0) {
        disabled = true
      } else {
        disabled = (state.selected1.length != 0 && state.selected1[0] != entry.id)
      }
      return {
        text: entry.name,
        value: entry.id,
        disabled: disabled
      }
    })
  },
  level2: state => {
    return state.level2.filter(entry => {
      return state.selected1.includes(entry.parent) && state.selected1.length > 0
    }).map(entry => {
      let disabled = false
      if (state.selected2.length != 0 && state.selected3.length != 0) {
        disabled = true
      } else {
        disabled = (state.selected2.length != 0 && state.selected2[0] != entry.id)
      }
      return {
        text: entry.name,
        value: entry.id,
        disabled: disabled
      }
    })
  },
  level3: state => {
    return state.level3.filter(entry => {
      return state.selected2.includes(entry.parent) && state.selected2.length > 0
    }).map(entry => {
      let disabled = false
      if (state.selected3.length != 0 && state.selected4.length != 0) {
        disabled = true
      } else {
        disabled = (state.selected3.length != 0 && state.selected3[0] != entry.id)
      }
      return {
        text: entry.name,
        value: entry.id,
        disabled: disabled
      }
    })
  },
  level4: state => {
    return state.level4.filter(entry => {
      return state.selected3.includes(entry.parent) && state.selected3.length > 0
    }).map(entry => {
      return {
        text: entry.name,
        value: entry.id,
        disabled: (state.selected4.length != 0 && state.selected4[0] != entry.id)
      }
    })
  },
  selected: state => {
    return [...state.selected1, ...state.selected2, ...state.selected3, ...state.selected4];
  },
  selected1: state => state.selected1,
  selected2: state => state.selected2,
  selected3: state => state.selected3,
  selected4: state => state.selected4
}

const actions = {
  list({
    commit,
    state
  }) {
    if (state.list.length === 0) {
      new Taxonomy().list()
        .then(response => {
          commit('setList', response)
          commit('setLevel1', response.filter(entry => {
            return entry.level == 1
          }))
          commit('setLevel2', response.filter(entry => {
            return entry.level == 2
          }))
          commit('setLevel3', response.filter(entry => {
            return entry.level == 3
          }))
          commit('setLevel4', response.filter(entry => {
            return entry.level == 4
          }))
        })
        .catch(error => {
          commit('setError', error)
        });
    }
  }
}

const mutations = {
  setList(state, list) {
    state.list = list;
  },
  setLevel1(state, list) {
    state.level1 = list;
  },
  setLevel2(state, list) {
    state.level2 = list;
  },
  setLevel3(state, list) {
    state.level3 = list;
  },
  setLevel4(state, list) {
    state.level4 = list;
  },
  setSelected1(state, selected) {
    state.selected1 = selected;
  },
  setSelected2(state, selected) {
    state.selected2 = selected;
  },
  setSelected3(state, selected) {
    state.selected3 = selected;
  },
  setSelected4(state, selected) {
    state.selected4 = selected;
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
