IF NOT EXISTS (SELECT * FROM sysobjects WHERE name ='LabAuditRecords' AND xtype='U')
    CREATE TABLE LabAuditRecords (
        AuditRecordId   INT NOT NULL IDENTITY PRIMARY KEY,
		AuditCreateTime DATETIME2 NOT NULL DEFAULT(GETUTCDATE()),
		AuditMessage    VARCHAR(100)
    )
GO

INSERT INTO LabAuditRecords (AuditMessage ) VALUES ( 'Message for testing data insertion')