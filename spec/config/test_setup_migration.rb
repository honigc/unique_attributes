class TestSetupMigration < ActiveRecord::Migration
  def up
    return if ActiveRecord::Base.connection.table_exists? :test_classes

    create_table :test_classes do |t|
      t.string :autogenerated_username
      t.string :other_field, null: false
    end
    add_index :test_classes, :autogenerated_username, unique: true
    add_index :test_classes, :other_field, unique: true

    create_table :scoped_test_classes do |t|
      t.string :autogenerated_username
      t.string :other_field
    end
    add_index :scoped_test_classes,
              [:autogenerated_username, :other_field],
              unique: true,
              name: :scoped_uniq_indx

    create_table :multiattribute_test_classes do |t|
      t.string :autogenerated_username
      t.string :autogenerated_password
    end
    add_index :multiattribute_test_classes,
              :autogenerated_username,
              unique: true
    add_index :multiattribute_test_classes,
              :autogenerated_password,
              unique: true
  end

  def down
    drop_table :test_classes
    drop_table :scoped_test_classes
    drop_table :multiattribute_test_classes
  end
end
