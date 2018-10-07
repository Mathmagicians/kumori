#Import principles
## No default values
No defualt values on import like missing, any - use nullable fields instead
No- nullable pt - id + name

## Entities general principles
* All entities must have a unique id field (ID)
* We construct primary keys as (ID, name) - postpone
* We use compound foreign keys (id, name) when referring to objects (dont need to fetch references to display links then) - postpone
* Full audit log on entities that are governed by techmenu - postponed
* 

# Entities 
## components
* id - unique + primiary key + required
* version - foreign key to id of componentVersions (id, name)
* deleted - soft delete flag
### componentVersions
* id - unique + primary key
* name - unique constraint  + required
* compoundkey (id, name)
* taxonomy - foreign key 
* component_version_usecases - componentversion has a  list of  usecasversions (implemented as *-* relation table)
* status - <<  in the future only as view element, remove status on entity, and replace with status på usecase[1]
* modified - timestamp used to track changes to entity <<< modified - could be seperate fact table
* modifiedby - text 
* modifiedcomment - text




