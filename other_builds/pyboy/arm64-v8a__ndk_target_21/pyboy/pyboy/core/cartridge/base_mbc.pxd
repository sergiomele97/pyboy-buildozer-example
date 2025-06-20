#
# License: See LICENSE.md file
# GitHub: https://github.com/Baekalfen/PyBoy
#

from libc.stdint cimport uint8_t, uint16_t, uint32_t

from pyboy.core.cartridge.rtc cimport RTC
from pyboy.logging.logging cimport Logger
from pyboy.utils cimport IntIOInterface


cdef Logger logger

cdef class BaseMBC:
    cdef str filename
    cdef str gamename
    cdef uint8_t[:, :] rombanks
    cdef uint8_t[:,:] rambanks
    cdef uint8_t carttype
    cdef bint battery
    cdef bint rtc_enabled
    cdef RTC rtc
    cdef uint8_t memorymodel
    cdef bint rambank_enabled
    cdef int external_ram_count
    cdef int external_rom_count
    cdef bint rambank_initialized
    cdef uint16_t rambank_selected
    cdef uint16_t rombank_selected
    cdef uint16_t rombank_selected_low
    cdef bint cgb

    cdef void save_state(self, IntIOInterface) noexcept
    cdef void load_state(self, IntIOInterface, int) noexcept
    cdef void save_ram(self, IntIOInterface) noexcept
    cdef void load_ram(self, IntIOInterface) noexcept
    cdef void init_rambanks(self, uint8_t) noexcept
    cdef str getgamename(self, uint8_t[:,:]) noexcept

    cdef uint8_t getitem(self, uint16_t) noexcept nogil
    cdef void setitem(self, uint16_t, uint8_t) noexcept nogil
    cdef void overrideitem(self, int, uint16_t, uint8_t) noexcept nogil

cdef class ROMOnly(BaseMBC):
    cdef void setitem(self, uint16_t, uint8_t) noexcept nogil
