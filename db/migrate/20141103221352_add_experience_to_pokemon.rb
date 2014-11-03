class AddExperienceToPokemon < ActiveRecord::Migration
  def change
    add_column :pokemons, :experience, :integer
  end
end
