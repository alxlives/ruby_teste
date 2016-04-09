class CreateAcessos < ActiveRecord::Migration
  def change
    create_table :acessos do |t|
      t.string :pagina
      t.timestamps
      t.references :contato, index: true, foreign_key: true
    end
  end
end
