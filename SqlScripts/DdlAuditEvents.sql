CREATE TABLE DdlAuditEvents
(
    Id uniqueidentifier,
    EventTime datetime,
    LoginName varchar(150),
    UserName varchar(150),
    DatabaseName varchar(150),
    SchemaName varchar(150),
    ObjectName varchar(150),
    ObjectType varchar(150),
    Command varchar(max),
    TriggerXml xml
);

CREATE TABLE DdlAuditColumnEvents
(
    Id uniqueidentifier,
    DdlAuditEventsId uniqueidentifier,
    EventTime datetime,
    LoginName varchar(150),
    UserName varchar(150),
    DatabaseName varchar(150),
    SchemaName varchar(150),
    ColumnName varchar(150),
    ChangeType varchar(25),
    Command varchar(max),
    TriggerXml xml
);