class AddLocaleToUser < ActiveRecord::Migration
  def change
    add_column :users, :locale, :char
  end
end
