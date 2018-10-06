export default {
	variant : {
      maybe: "secondary",
      buy: "primary", 
      hold: "success",
      sell: "danger"
    },
	filters: {
		outline() {
			return 'outline-';
		}
	},
	computed: {
      types: function() {
        return this.$store.getters.lifeCycle.items.map( item => item.type).filter((v, i, a) => a.indexOf(v) === i);
      },
      itemsForType: function() {
        const namesForType = type =>  this.$store.getters.lifeCycle.items.filter( item => item.type === type).map( item => item.name);
        const myMap = new Map();
        this.types.forEach( type =>  myMap[type] = namesForType(type));
        return myMap;
      }
    },
    methods: {
    	btnVariant(type){
    		return type?this.$options.variant[type]:'';
      },
      // todo - unit test!
      // returns a list of root elements, that are trees built from parent-child relations in the flatList. Assumes name, parent and no loops.
      // test data: [{"name":"A", parent:"null"},{"name":"B", parent:"A"}, {"name":"C", parent:"A"}, {"name":"D", parent:""}]
      // assert  [ { "name": "A", "parent": "null", "children": [ { "name": "B", "parent": "A", "children": [] }, { "name": "C", "parent": "A", "children": [] } ] }, { "name": "D", "parent": "", "children": [] } ]
      buildTree( flatList ) {
        const nonExists = ( e ) => { return (e=== 'null') || (e=== null) || (e=== undefined) || (e === '') || (e ===[])}
        let tree = [];
        let lookUp = {};

        if( nonExists() ) return tree;

        //we work on a copy to treeify  
        let myCopy = [...flatList];
        console.log("building tree from")
        console.log(flatList)
        
        myCopy.forEach( el => { 
          lookUp[ el.name] = el; 
          el.children = [];
        });

        myCopy.forEach( el => {
          if(  nonExists(el.parent) ){
            //it is a root
            tree.push(el);
          } else {
            lookUp[el.parent].children.push(el);
          }
        });

        console.log( "tree is")
        console.log(tree)
        return tree;
      },

       /** fixme: test
      isTagInTech({name:"Development team instant messaging"}, tech[0])
      true
      isTagInTech6({name:"Application Development"}, tech[0])
      false

      countTagInTechs6( "Development team instant messaging", [tech[0], tech[1]])
      1
      countTagInTechs6( "Delivery Services", [tech[0], tech[1]])
      2
        */
        sizesForTaxonomies(tags, techs){
          const isTagInTech = (tag,tech) => tech.tags.filter( atag => atag === tag.name).length>0
          const countTagInTechs = ( tag, techs) => techs.reduce( (sum,tech) => isTagInTech(tag,tech)?sum+1:sum,0 )
          let am =  tags.map( tag => ({ ...tag, size: countTagInTechs( tag, techs)}))
          console.log("Computed sizes")
          console.log(am)
          return am
        },

      saveFile: function( treeObj ) {
        const data = JSON.stringify(treeObj);
        window.localStorage.setItem('treeObj', data);
        console.log( "saved to local storage as "+ 'treeObj');
      }

    }
}