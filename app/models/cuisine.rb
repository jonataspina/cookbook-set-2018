class Cuisine < ApplicationRecord
  has_many :recipes

  validates :name, presence: { message: "Você deve preencher todos os campos" }
  validates :id, uniqueness: {message: "Esse tipo de cozinha já existe"}

end
