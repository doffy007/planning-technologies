package main

import (
	"fmt"
	"math/rand"
)

type Pemain struct {
	ID          int
	Dadu        []int
	Nilai       int
	Berikutnya  *Pemain
	StatusHidup bool
}

func main() {
	nomorPemain := 3
	nomorDadu := 4

	paraPemain := inisiasiPemain(nomorPemain, nomorDadu)

	fmt.Println("==================")
	fmt.Printf("Pemain = %d, Dadu = %d\n", nomorPemain, nomorDadu)
	fmt.Println("==================")

	giliran := 1
	for {
		fmt.Printf("Giliran %d lempar dadu:\n", giliran)
		giliran++

		pemainAktif := make([]*Pemain, 0)
		for i := 0; i < nomorPemain; i++ {
			if paraPemain[i].StatusHidup {
				paraPemain[i].PutaranDadu()
				pemainAktif = append(pemainAktif, paraPemain[i])
			}
		}

		for _, pemain := range pemainAktif {
			fmt.Printf("Pemain #%d (%d): %v\n", pemain.ID, pemain.Nilai, pemain.Dadu)
		}

		if len(pemainAktif) == 1 {
			fmt.Printf("Game berakhir karena hanya pemain #%d yang memiliki dadu.\n", pemainAktif[0].ID)
			break
		}

		fmt.Println("Setelah evaluasi:")
		for _, pemain := range pemainAktif {
			pemain.Evaluasi(pemainAktif)
			fmt.Printf("Pemain #%d (%d): %v\n", pemain.ID, pemain.Nilai, pemain.Dadu)
		}

		fmt.Println("==================")
	}

	winner := paraPemain[0]
	for i := 1; i < nomorPemain; i++ {
		if paraPemain[i].Nilai > winner.Nilai {
			winner = paraPemain[i]
		}
	}

	fmt.Printf("Game dimenangkan oleh pemain #%d karena memiliki poin lebih banyak dari pemain lainnya.\n", winner.ID)
}

func inisiasiPemain(nomorPemain, nomorDadu int) []*Pemain {
	paraPemain := make([]*Pemain, nomorPemain)
	for i := 0; i < nomorPemain; i++ {
		paraPemain[i] = &Pemain{
			ID:          i + 1,
			Dadu:        make([]int, nomorDadu),
			Nilai:       0,
			Berikutnya:  nil,
			StatusHidup: true,
		}

		if i > 0 {
			paraPemain[i-1].Berikutnya = paraPemain[i]
		}
	}

	paraPemain[nomorPemain-1].Berikutnya = paraPemain[0]
	return paraPemain
}

func (p *Pemain) PutaranDadu() {
	for i := range p.Dadu {
		p.Dadu[i] = rand.Intn(6) + 1
	}
}

func (p *Pemain) Evaluasi(pemainAktif []*Pemain) {
	for i := 0; i < len(p.Dadu); i++ {
		dadu := p.Dadu[i]
		if dadu == 6 {
			p.Nilai++
			p.Dadu = append(p.Dadu[:i], p.Dadu[i+1:]...)
			i--
		} else if dadu == 1 {
			pemainBerikut := p.Berikutnya
			for pemainBerikut == p || !pemainBerikut.StatusHidup {
				pemainBerikut = pemainBerikut.Berikutnya
			}
			pemainBerikut.Dadu = append(pemainBerikut.Dadu, 1)
			p.Dadu = append(p.Dadu[:i], p.Dadu[i+1:]...)
			i--
		}
	}

	if len(p.Dadu) == 0 {
		p.StatusHidup = false
	}
}
