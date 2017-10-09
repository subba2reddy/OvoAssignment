public class clsStaticResCtrl {
    @AuraEnabled
    public static string getFileText( ){
        StaticResource srObject = [select id,body from StaticResource Where Name = 'AUTypeTextTest'];
        String strFileContent = srObject.body.toString();
        return strFileContent;
    }
    
    @AuraEnabled
    public static string updateTextFile(String strFileContent){
        MetadataService.MetadataPort service = new MetadataService.MetadataPort();     
        service.SessionHeader = new MetadataService.SessionHeader_element();
        //service.SessionHeader.sessionId = UserInfo.getSessionId();
        service.SessionHeader.sessionId = getSessionId();
        MetadataService.StaticResource staticResource = new MetadataService.StaticResource();
        staticResource.fullName = 'AUTypeTextTest';
        staticResource.contentType = 'text';
        staticResource.cacheControl = 'public';
        staticResource.content = EncodingUtil.base64Encode(Blob.valueOf(strFileContent));
        List<MetadataService.SaveResult> results = service.updateMetadata(new MetadataService.Metadata[] { staticResource });      
        
        return 'Data Saved';
    }
    
    private static string getSessionId(){
        PageReference vfSessionIdGenerator = Page.vfSessionIdGenerator;
        String content = vfSessionIdGenerator.getContent().toString();
        System.debug('The value -- ' + content );
        Integer s = content.indexOf('Start') + 'Start'.length(),
                e = content.indexOf('End');
        return content.substring(s, e);       
    }
}