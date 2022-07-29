resource_manifest_version '77731fab-63ca-442c-a67b-abc70f28dfa5'

files {
    --camaro    
    'cars/camaro/vehicles.meta',
    'cars/camaro/carvariations.meta',
    'cars/camaro/carcols.meta',
    'cars/camaro/handling.meta', 
    
    --mustang    
    'cars/mustang/vehicles.meta',
    'cars/mustang/carvariations.meta',
    'cars/mustang/carcols.meta',
    'cars/mustang/handling.meta', 
    
	
   
    

    --  THE LAST LINE ITEM ABOVE SHOULD NOT HAVE A COMMA ( , ) AT THE END
    
    --'vehiclelayouts.meta',    -- Not Required, only used on some addons
}

--camaro
data_file 'HANDLING_FILE' 'cars/camaro/handling.meta'
data_file 'VEHICLE_METADATA_FILE' 'cars/camaro/vehicles.meta'
data_file 'CARCOLS_FILE' 'cars/camaro/carcols.meta'
data_file 'VEHICLE_VARIATION_FILE' 'cars/camaro/carvariations.meta'

--mustang
data_file 'HANDLING_FILE' 'cars/mustang/handling.meta'
data_file 'VEHICLE_METADATA_FILE' 'cars/mustang/vehicles.meta'
data_file 'CARCOLS_FILE' 'cars/mustang/carcols.meta'
data_file 'VEHICLE_VARIATION_FILE' 'cars/mustang/carvariations.meta'



--data_file 'VEHICLE_LAYOUTS_FILE' 'vehiclelayouts.meta' --not required, only used on some addons
