create trigger DdlAuditEventsTrigger on database for CREATE_TABLE, ALTER_TABLE, DROP_TABLE as
  declare @event xml;
  declare @columnEvent xml;
  declare @id uniqueidentifier;

  set @id = NEWID();
  set @event = EVENTDATA();
  set @columnEvent = @event.query('/EVENT_INSTANCE/AlterTableActionList')
  insert into DdlAuditEvents
  values
  (
    @id,
    replace(convert(varchar(50), @event.query('data(/EVENT_INSTANCE/PostTime)')), 'T', ' '),
    convert(varchar(150), @event.query('data(/EVENT_INSTANCE/LoginName)')),
    convert(varchar(150), @event.query('data(/EVENT_INSTANCE/UserName)')),
    convert(varchar(150), @event.query('data(/EVENT_INSTANCE/DatabaseName)')),
    convert(varchar(150), @event.query('data(/EVENT_INSTANCE/SchemaName)')),
    convert(varchar(150), @event.query('data(/EVENT_INSTANCE/ObjectName)')),
    convert(varchar(150), @event.query('data(/EVENT_INSTANCE/ObjectType)')),
    convert(varchar(max), @event.query('data(/EVENT_INSTANCE/TSQLCommand/CommandText)')),
    @event
  );

  insert into [DdlAuditColumnEvents]
  (
    [Id],
    [DdlAuditEventsId],
    [EventTime],
    [LoginName],
    [UserName],
    [DatabaseName],
    [SchemaName],
    [ColumnName],
    [ChangeType],
    [Command],
    [TriggerXml]
  )
  select
    NEWID(),
    @id,
    replace(convert(varchar(50), @event.query('data(/EVENT_INSTANCE/PostTime)')), 'T', ' '),
    convert(varchar(150), @event.query('data(/EVENT_INSTANCE/LoginName)')),
    convert(varchar(150), @event.query('data(/EVENT_INSTANCE/UserName)')),
    convert(varchar(150), @event.query('data(/EVENT_INSTANCE/DatabaseName)')),
    convert(varchar(150), @event.query('data(/EVENT_INSTANCE/SchemaName)')),
    DdlColumnDeleteEvent.Col.value('.', 'varchar(max)'),
    'Drop',
    convert(varchar(max), @event.query('data(/EVENT_INSTANCE/TSQLCommand/CommandText)')),
    @event
  from @columnEvent.nodes('/AlterTableActionList/Drop/Columns/Name') as DdlColumnDeleteEvent(Col);

  insert into [DdlAuditColumnEvents]
  (
    [Id],
    [DdlAuditEventsId],
    [EventTime],
    [LoginName],
    [UserName],
    [DatabaseName],
    [SchemaName],
    [ColumnName],
    [ChangeType],
    [Command],
    [TriggerXml]
  )
  select
    NEWID(),
    @id,
    replace(convert(varchar(50), @event.query('data(/EVENT_INSTANCE/PostTime)')), 'T', ' '),
    convert(varchar(150), @event.query('data(/EVENT_INSTANCE/LoginName)')),
    convert(varchar(150), @event.query('data(/EVENT_INSTANCE/UserName)')),
    convert(varchar(150), @event.query('data(/EVENT_INSTANCE/DatabaseName)')),
    convert(varchar(150), @event.query('data(/EVENT_INSTANCE/SchemaName)')),
    DdlColumnCreateEvent.Col.value('.', 'varchar(max)'),
    'Create',
    convert(varchar(max), @event.query('data(/EVENT_INSTANCE/TSQLCommand/CommandText)')),
    @event
  from @columnEvent.nodes('/AlterTableActionList/Create/Columns/Name') as DdlColumnCreateEvent(Col);

  insert into [DdlAuditColumnEvents]
  (
    [Id],
    [DdlAuditEventsId],
    [EventTime],
    [LoginName],
    [UserName],
    [DatabaseName],
    [SchemaName],
    [ColumnName],
    [ChangeType],
    [Command],
    [TriggerXml]
  )
  select
    NEWID(),
    @id,
    replace(convert(varchar(50), @event.query('data(/EVENT_INSTANCE/PostTime)')), 'T', ' '),
    convert(varchar(150), @event.query('data(/EVENT_INSTANCE/LoginName)')),
    convert(varchar(150), @event.query('data(/EVENT_INSTANCE/UserName)')),
    convert(varchar(150), @event.query('data(/EVENT_INSTANCE/DatabaseName)')),
    convert(varchar(150), @event.query('data(/EVENT_INSTANCE/SchemaName)')),
    DdlColumnAlterEvent.Col.value('.', 'varchar(max)'),
    'Alter',
    convert(varchar(max), @event.query('data(/EVENT_INSTANCE/TSQLCommand/CommandText)')),
    @event
  from @columnEvent.nodes('/AlterTableActionList/Alter/Columns/Name') as DdlColumnAlterEvent(Col);  