object frmDataModule: TfrmDataModule
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 82
  Width = 280
  object uniConnection: TUniConnection
    ProviderName = 'SQLite'
    Database = 'Database.db'
    Left = 32
    Top = 8
  end
  object uniProvider: TSQLiteUniProvider
    Left = 128
    Top = 8
  end
  object uniMonitor: TUniSQLMonitor
    Active = False
    Left = 224
    Top = 8
  end
end
