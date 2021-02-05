package ar.edu.unsam.libros.dao

import ar.edu.unsam.libros.domain.Libro
import java.util.Collection
import org.springframework.data.mongodb.repository.MongoRepository
import org.springframework.data.mongodb.repository.Query

interface LibroRepository extends MongoRepository<Libro, Long> {
	
	def Libro findByTitulo(String titulo)

	@Query("{ estado : 'D', activo: true, titulo: {'$regex': ?0, '$options': 'i'} }")
	def Collection<Libro> getLibrosPrestables(String valorABuscar)
}