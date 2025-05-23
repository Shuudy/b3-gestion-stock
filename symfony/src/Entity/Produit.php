<?php

namespace App\Entity;

use App\Repository\ProduitRepository;
use Doctrine\Common\Collections\ArrayCollection;
use Doctrine\Common\Collections\Collection;
use Doctrine\DBAL\Types\Types;
use Doctrine\ORM\Mapping as ORM;

#[ORM\Entity(repositoryClass: ProduitRepository::class)]
class Produit
{
    #[ORM\Id]
    #[ORM\GeneratedValue]
    #[ORM\Column]
    private ?int $id = null;

    #[ORM\Column(length: 100)]
    private ?string $nom = null;

    #[ORM\Column(length: 100, nullable: true)]
    private ?string $description = null;

    #[ORM\Column]
    private ?int $quantite = null;

    #[ORM\Column(type: Types::DECIMAL, precision: 10, scale: 2)]
    private ?string $prix = null;

    #[ORM\Column(length: 30)]
    private ?string $categorie = null;

    /**
     * @var Collection<int, AchatProduit>
     */
    #[ORM\OneToMany(targetEntity: AchatProduit::class, mappedBy: 'achat')]
    private Collection $achatProduits;

    public function __construct()
    {
        $this->achatProduits = new ArrayCollection();
    }

    public function getId(): ?int
    {
        return $this->id;
    }

    public function getNom(): ?string
    {
        return $this->nom;
    }

    public function setNom(string $nom): static
    {
        $this->nom = $nom;

        return $this;
    }

    public function getDescription(): ?string
    {
        return $this->description;
    }

    public function setDescription(?string $description): static
    {
        $this->description = $description;

        return $this;
    }

    public function getQuantite(): ?int
    {
        return $this->quantite;
    }

    public function setQuantite(int $quantite): static
    {
        $this->quantite = $quantite;

        return $this;
    }

    public function getPrix(): ?string
    {
        return $this->prix;
    }

    public function setPrix(string $prix): static
    {
        $this->prix = $prix;

        return $this;
    }

    public function getCategories(): ?string
    {
        return $this->categories;
    }

    public function setCategories(string $categories): static
    {
        $this->categories = $categories;

        return $this;
    }

    public function getCategorie(): ?string
    {
        return $this->categorie;
    }

    public function setCategorie(string $categorie): static
    {
        $this->categorie = $categorie;

        return $this;
    }

    /**
     * @return Collection<int, AchatProduit>
     */
    public function getAchatProduits(): Collection
    {
        return $this->achatProduits;
    }

    public function addAchatProduit(AchatProduit $achatProduit): static
    {
        if (!$this->achatProduits->contains($achatProduit)) {
            $this->achatProduits->add($achatProduit);
            $achatProduit->setAchat($this);
        }

        return $this;
    }

    public function removeAchatProduit(AchatProduit $achatProduit): static
    {
        if ($this->achatProduits->removeElement($achatProduit)) {
            // set the owning side to null (unless already changed)
            if ($achatProduit->getAchat() === $this) {
                $achatProduit->setAchat(null);
            }
        }

        return $this;
    }
}
