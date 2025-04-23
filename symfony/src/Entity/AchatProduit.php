<?php

namespace App\Entity;

use App\Repository\AchatProduitRepository;
use Doctrine\ORM\Mapping as ORM;

#[ORM\Entity(repositoryClass: AchatProduitRepository::class)]
class AchatProduit
{
    #[ORM\Id]
    #[ORM\ManyToOne(inversedBy: 'achatProduits')]
    #[ORM\JoinColumn(nullable: false)]
    private ?Produit $produit = null;

    #[ORM\ManyToOne(inversedBy: 'achatProduits')]
    #[ORM\JoinColumn(nullable: false)]
    private ?Produit $achat = null;

    public function getId(): ?int
    {
        return $this->id;
    }

    public function getProduit(): ?Produit
    {
        return $this->produit;
    }

    public function setProduit(?Produit $produit): static
    {
        $this->produit = $produit;

        return $this;
    }

    public function getAchat(): ?Produit
    {
        return $this->achat;
    }

    public function setAchat(?Produit $achat): static
    {
        $this->achat = $achat;

        return $this;
    }
}
