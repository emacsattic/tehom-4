;;; tehom-4.el --- A variant completing-read that returns value

;; Copyright (C) 1999 by Tom Breton

;; Author: Tom Breton <Tehom@localhost>
;; Keywords: extensions

;; This file is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 2, or (at your option)
;; any later version.

;; This file is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with GNU Emacs; see the file COPYING.  If not, write to
;; the Free Software Foundation, Inc., 59 Temple Place - Suite 330,
;; Boston, MA 02111-1307, USA.

;;; Commentary:

;; I've written the completing-read...assoc...cdr sequence so often to
;; interactively look up an element in an alist.  Here it is
;; encapsulated in one function.  It supports obarrays too.

;;; Code:

(require 'cl)  ;;Needed for assert.

(defun tehom-completing-read-assoc 
  ( prompt table 
    &optional predicate require-match init hist def
    inherit-input-method)

  "Interactively look up a value in an alist.

If the user aborts, return nil.

This is like completing-read, but returns the associated value.  In
contrast, completing-read returns the key, ie the string itself.

Parameters are the same as completing-read, but REQUIRE-MATCH is
ignored.  t is always used instead.  It would make little sense to ask
for associated data if the user may type any possible string."

  (let*
    (
      (element-name
	(completing-read prompt table 
	  predicate t init hist def
	  inherit-input-method)))

    (assert (stringp element-name))

    (cond
      ;;The user aborted.
      ( (string= element-name "")
	nil)

      ;;Handle the different types of collections.

      ;;alist
      ((consp table)
	(cdr (assoc element-name table)))

      ;;obarray
      ((arrayp table)
	(intern-soft element-name table)))))


(provide 'tehom-4)

;;; tehom-4.el ends here