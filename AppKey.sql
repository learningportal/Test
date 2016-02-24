Begin tran

USE TescoDotComApiUsers
GO

DECLARE 
@P_UserKey varchar(50),
@P_UserName varchar(50),
@P_UserPassword varchar(50)='password',
@P_ApplicationKey varchar(50)='96A364DD-2A28-4EA6-98AB-43CC28455A3C',
@P_ApplicationName varchar(50)



IF NOT EXISTS(SELECT 1 FROM [dbo].[Users] where [UserKey] = @P_UserKey)
	BEGIN
		INSERT [dbo].[Users] 
			(	[UserKey], 
				[Username],
				[Password]
			 ) 
			VALUES 
			(	@P_UserKey,
				@P_UserName,
				@P_UserPassword
			 )					
	END
ELSE
	BEGIN
		PRINT 'Record(s) already existed in [dbo].[Users].'
	END
	
IF NOT EXISTS(SELECT 1 FROM [dbo].[Applications] where [ApplicationKey] = @P_ApplicationKey)
	BEGIN		
		
		INSERT [dbo].[Applications] 
					([ApplicationKey],
					 [AppName],
					 [AppOwnerEmail],
					 [Trusted]) 
					 VALUES 
					 (
					 @P_ApplicationKey,
					 @P_ApplicationName,
					 NULL,
					 1)
			
	END
ELSE
	BEGIN
		PRINT 'Record(s) already existed in [dbo].[Applications].'
	END
	
DECLARE @userId int,
		@applicationId int

SELECT @userId = UserId  FROM [dbo].Users WHERE UserKey = @P_UserKey
SELECT @applicationId = ApplicationId  FROM [dbo].Applications WHERE ApplicationKey = @P_ApplicationKey

IF NOT EXISTS(SELECT 1 FROM [dbo].[UserApplications] where [UserId]= @userId and [ApplicationId] = @applicationId )
	BEGIN
	
		INSERT [dbo].[UserApplications] 
				([UserId], 
				[ApplicationId]) 
				VALUES 
				(
				@userId, 
				@applicationId
				)
		
	END
ELSE
	BEGIN
		PRINT 'Record(s) already existed in [dbo].[UserApplications].'
	END
	
	
	
USE TescoConfiguration
GO
	
DECLARE @configSectionMasterId int	
DECLARE @configKeyCustomerOrder varchar(50) = '*.96A364DD-2A28-4EA6-98AB-43CC28455A3C.Customer.CustomerOrder.CustomerOrder.*.access'
DECLARE @configKeyPromotion varchar(50) = '*.96A364DD-2A28-4EA6-98AB-43CC28455A3C.Customer.Promotion.Promotion.*.access'
DECLARE @configKeyPrice varchar(50) = '*.96A364DD-2A28-4EA6-98AB-43CC28455A3C.Customer.Price.Price.*.access'
DECLARE @configKeyRange varchar(50) = '*.96A364DD-2A28-4EA6-98AB-43CC28455A3C.Customer.Range.Range.*.access'
DECLARE @configKeyProduct varchar(50) = '*.96A364DD-2A28-4EA6-98AB-43CC28455A3C.Customer.Product.Product.*.access'
DECLARE @configKeyProductList varchar(50) = '*.96A364DD-2A28-4EA6-98AB-43CC28455A3C.Customer.ProductList.ProductList.*.access'
DECLARE @configKeyTescoLocation varchar(50) = '*.96A364DD-2A28-4EA6-98AB-43CC28455A3C.Customer.TescoLocation.TescoLocation.*.access'
DECLARE @configKeyTransport varchar(50) = '*.96A364DD-2A28-4EA6-98AB-43CC28455A3C.TransportAndTracking.TransportAndTracking.*.access'
DECLARE @configKeySearch varchar(50) = '*.96A364DD-2A28-4EA6-98AB-43CC28455A3C.Customer.Search.Search.*.access'
DECLARE @configKeyAddress varchar(50) = '*.96A364DD-2A28-4EA6-98AB-43CC28455A3C.Customer.Address.Address.*.access'


SELECT @configSectionMasterId = configSectionMasterId FROM [dbo].ConfigSectionMaster WHERE configSectionName = 'users.permissions'

INSERT [dbo].[ConfigSectionValues] ([configSectionMasterId], [configSectionKey],[configSectionValue]) VALUES (@configSectionMasterId,@configKeyCustomerOrder,'1')
INSERT [dbo].[ConfigSectionValues] ([configSectionMasterId], [configSectionKey],[configSectionValue]) VALUES (@configSectionMasterId,@configKeyPromotion,'1')
INSERT [dbo].[ConfigSectionValues] ([configSectionMasterId], [configSectionKey],[configSectionValue]) VALUES (@configSectionMasterId,@configKeyPrice,'1')
INSERT [dbo].[ConfigSectionValues] ([configSectionMasterId], [configSectionKey],[configSectionValue]) VALUES (@configSectionMasterId,@configKeyRange,'1')
INSERT [dbo].[ConfigSectionValues] ([configSectionMasterId], [configSectionKey],[configSectionValue]) VALUES (@configSectionMasterId,@configKeyProduct,'1')
INSERT [dbo].[ConfigSectionValues] ([configSectionMasterId], [configSectionKey],[configSectionValue]) VALUES (@configSectionMasterId,@configKeyProductList,'1')
INSERT [dbo].[ConfigSectionValues] ([configSectionMasterId], [configSectionKey],[configSectionValue]) VALUES (@configSectionMasterId,@configKeyRange,'1')
INSERT [dbo].[ConfigSectionValues] ([configSectionMasterId], [configSectionKey],[configSectionValue]) VALUES (@configSectionMasterId,@configKeyTescoLocation,'1')
INSERT [dbo].[ConfigSectionValues] ([configSectionMasterId], [configSectionKey],[configSectionValue]) VALUES (@configSectionMasterId,@configKeyTransport,'1')
INSERT [dbo].[ConfigSectionValues] ([configSectionMasterId], [configSectionKey],[configSectionValue]) VALUES (@configSectionMasterId,@configKeySearch,'1')
INSERT [dbo].[ConfigSectionValues] ([configSectionMasterId], [configSectionKey],[configSectionValue]) VALUES (@configSectionMasterId,@configKeyAddress,'1')


Rollback tran