package ar.edu.unsam.libros.controller

import ar.edu.unsam.libros.UserException
import ar.edu.unsam.libros.dao.LibroRepository
import ar.edu.unsam.libros.dao.PrestamoRepository
import ar.edu.unsam.libros.domain.Prestamo
import io.swagger.annotations.ApiOperation
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.http.ResponseEntity
import org.springframework.web.bind.annotation.CrossOrigin
import org.springframework.web.bind.annotation.GetMapping
import org.springframework.web.bind.annotation.PatchMapping
import org.springframework.web.bind.annotation.PostMapping
import org.springframework.web.bind.annotation.RequestBody
import org.springframework.web.bind.annotation.RestController

@RestController
@CrossOrigin(origins = "*")
class PrestamoController {
	
	@Autowired
	PrestamoRepository prestamoRepository
	
	@Autowired
	LibroRepository libroRepository
	
	@GetMapping(value = "/prestamos")
	@ApiOperation("Permite conocer los préstamos pendientes del sistema, es decir, aquellos libros que están en poder de alguna persona.")
	def getPrestamos() {
		this.prestamoRepository.getPrestamosPendientes
	}
  
	@PostMapping("/prestamos")
	@ApiOperation("Permite crear un préstamo, asociando una persona con un libro. El libro deja de estar disponible.")
	def prestar(@RequestBody Prestamo prestamo) {
		try {
			val libro = libroRepository.findById(prestamo.libro.id).orElseThrow([ new UserException("El libro con id " + prestamo.libro.id + " no existe" )])
			prestamo.libro = libro
			prestamo.validar
			prestamoRepository.save(prestamo)
			libro.prestar
			libroRepository.save(libro)
			ResponseEntity.ok.body("Se generó el préstamo correctamente")
		} catch (UserException e) {
			ResponseEntity.badRequest.body(e.message)
		}
	}

	@PatchMapping("/prestamos")
	@ApiOperation("Permite devolver el libro a la biblioteca. El libro vuelve a estar disponible.")
	def devolver(@RequestBody Prestamo prestamoOrigen) {
		try {
			val prestamo = prestamoRepository.findById(prestamoOrigen.id).orElseThrow([ new UserException("El préstamo con id " + prestamoOrigen.id + " no existe" )])
			val libro = libroRepository.findById(prestamo.libro.id).orElseThrow([ new UserException("El libro con id " + prestamo.libro.id + " no existe" )])
			prestamo.libro = libro
			prestamo.validarDevolucion
			prestamo.devolver
			prestamoRepository.save(prestamo)
			libroRepository.save(libro)
			ResponseEntity.ok.body("Se devolvió el libro correctamente")
		} catch (UserException e) {
			ResponseEntity.badRequest.body(e.message)
		}
	}  

}