class PokemonController < ApplicationController

	def new
		@pokemon = Pokemon.new
	end

    def capture
		@pokemon = Pokemon.find(params[:id])
		@trainer = current_trainer
		@pokemon.trainer_id = @trainer.id
		@pokemon.save
		redirect_to root_path
	end
    
    def destroy
		@pokemon = Pokemon.find(params[:id])
		@trainer = Trainer.find(@pokemon.trainer_id)
		Pokemon.destroy(@pokemon.id)
		redirect_to @trainer
	end
    
	def create
		@pokemon = Pokemon.new(pokemon_params)
		@pokemon.level = 1
		@pokemon.health = 100
		@pokemon.experience = 0
		@trainer = current_trainer
		@pokemon.trainer_id = @trainer.id
		if (@pokemon.save)
			redirect_to @trainer
		else
			redirect_to new_pokemon_path
			flash[:error] = @pokemon.errors.full_messages.to_sentence
		end
	end

	def damage
		@pokemon = Pokemon.find(params[:id])
		@trainer = Trainer.find(@pokemon.trainer_id)
		@pokemon.health = @pokemon.health - 10
		if (@pokemon.health < 0)
			@pokemon.health = 0
		end
		@pokemon.save

		@mypokemon = Pokemon.find(params[:pokemon][:id])
		@mypokemon.experience = @mypokemon.experience + 20
		if (@mypokemon.experience >= 100 and @mypokemon.level < 100)
			@mypokemon.level = @mypokemon.level + 1
			@mypokemon.experience = 0
		end
		@mypokemon.save
		redirect_to @trainer
	end

	def heal
		@pokemon = Pokemon.find(params[:id])
		@trainer = Trainer.find(@pokemon.trainer_id)
		@pokemon.health = @pokemon.health + 10
		if (@pokemon.health > 100)
			@pokemon.health = 100
		end
		@pokemon.save
		redirect_to @trainer
	end

	private
	def attack_params
		params.require(:pokemon).permit(:id)
	end

	private
	def pokemon_params
		params.require(:pokemon).permit(:name)
	end
end
