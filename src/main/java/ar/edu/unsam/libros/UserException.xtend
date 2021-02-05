package ar.edu.unsam.libros

import java.lang.RuntimeException

class UserException extends RuntimeException {
	
	new(String message) { super(message) }
}