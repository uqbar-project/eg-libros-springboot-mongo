package ar.edu.unsam.libros.dao

import ar.edu.unsam.libros.domain.Libro
import ar.edu.unsam.libros.domain.Prestamo
import java.util.Collection
import org.springframework.data.mongodb.repository.MongoRepository
import org.springframework.data.mongodb.repository.Query

interface PrestamoRepository extends MongoRepository<Prestamo, String> {
	
	def Libro findByLibro(Libro libro)
	
	@Query("{ fechaDevolucion : { $exists: false } }")
	def Collection<Prestamo> getPrestamosPendientes()

}
