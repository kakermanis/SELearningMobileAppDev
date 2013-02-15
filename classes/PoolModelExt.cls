public class PoolModelExt {

    public PoolModelExt(ApexPages.StandardController controller) {

    }
    
    
    @RemoteAction
    public static SearchWrapper searchPools(String searchTerm) {
        List<Pool_Model__c> foundPools = new List<Pool_Model__c>();
        SearchWrapper searchWrapper = new SearchWrapper();
                        
        String soslQuery = ' FIND {*' + searchTerm +  '*} IN ALL FIELDS RETURNING Pool_Model__c (Id, Name, width__c, length__c, rrp__c)';
        List<List <sObject>> myQuery = search.query(soslQuery);         
        foundPools = myQuery.get(0);
        
        searchWrapper.foundPools = foundPools;
        
        return searchWrapper;
    } 
    
    @RemoteAction
    public static Pool_Model__c getPoolDetails(String poolId) {
        Pool_Model__c foundPool;                        
        String query = 'SELECT ';
        for(Schema.FieldSetMember f : getFields()) {
            query += f.getFieldPath() + ', ';
        }
        
        query = query.subString(0, query.length() -2);     
        query += ' FROM Pool_Model__c WHERE id =: poolId';
        
        System.debug('Pool Detail Query is: ' + query);
                       
        foundPool = Database.query(query);                                        
        return foundPool;
    }  
    
    public static List<Schema.FieldSetMember> getFields() {
        return SObjectType.Pool_Model__c.FieldSets.Pool_Detail_Fields.getFields();
    }    
    
    public class SearchWrapper {
        public List<Pool_Model__c> foundPools {set;get;}
    }
     
}