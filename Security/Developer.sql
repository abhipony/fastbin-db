CREATE ROLE [Developer]
    AUTHORIZATION [dbo];


GO
ALTER ROLE [Developer] ADD MEMBER [_is_dwrp];


GO
ALTER ROLE [Developer] ADD MEMBER [_is_idc_dotnet_sms];

