package ar.edu.unsam.libros.controller

import ar.edu.unsam.libros.domain.Prestamo
import ar.edu.unsam.libros.service.PrestamoService
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
	PrestamoService prestamoService
	
	@GetMapping(value = "/prestamos")
	@ApiOperation("Permite conocer los préstamos pendientes del sistema, es decir, aquellos libros que están en poder de alguna persona.")
	def getPrestamos() {
		this.prestamoService.getPrestamosPendientes
	}
  
	@PostMapping("/prestamos")
	@ApiOperation("Permite crear un préstamo, asociando una persona con un libro. El libro deja de estar disponible.")
	def prestar(@RequestBody Prestamo prestamo) {
		prestamoService.generarPrestamo(prestamo)
		ResponseEntity.ok.body("Se generó el préstamo correctamente")
	}

	@PatchMapping("/prestamos")
	@ApiOperation("Permite devolver el libro a la biblioteca. El libro vuelve a estar disponible.")
	def devolver(@RequestBody Prestamo prestamoOrigen) {
		prestamoService.devolverPrestamo(prestamoOrigen)
		ResponseEntity.ok.body("Se devolvió el libro correctamente")
	}

}