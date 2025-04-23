<?php

namespace App\Entity;

use App\Repository\StockTotalRepository;
use Doctrine\DBAL\Types\Types;
use Doctrine\ORM\Mapping as ORM;

#[ORM\Entity(repositoryClass: StockTotalRepository::class)]
class StockTotal
{
    #[ORM\Id]
    #[ORM\GeneratedValue]
    #[ORM\Column]
    private ?int $id = null;

    #[ORM\Column]
    private ?int $total_stock = null;

    #[ORM\Column(type: Types::DATE_MUTABLE)]
    private ?\DateTimeInterface $derniere_maj = null;

    public function getId(): ?int
    {
        return $this->id;
    }

    public function getTotalStock(): ?int
    {
        return $this->total_stock;
    }

    public function setTotalStock(int $total_stock): static
    {
        $this->total_stock = $total_stock;

        return $this;
    }

    public function getDerniereMaj(): ?\DateTimeInterface
    {
        return $this->derniere_maj;
    }

    public function setDerniereMaj(\DateTimeInterface $derniere_maj): static
    {
        $this->derniere_maj = $derniere_maj;

        return $this;
    }
}
