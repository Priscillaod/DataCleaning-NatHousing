
--Looking the entire dataset

select*
from housing_data.dbo.NashvilleHousing


-- Change date format from date-time to date


select SaleDateConverted , CONVERT(Date, SaleDate)
from housing_data.dbo.NashvilleHousing


UPDATE NashvilleHousing
SET SaleDate  = CONVERT (Date, SaleDate)

ALTER TABLE NashvilleHousing
Add SaleDateConverted Date;

UPDATE NashvilleHousing
SET SaleDateConverted  = CONVERT (Date, SaleDate)


-- Populate the property address data and fill up the NULLs

select PropertyAddress
from housing_data.dbo.NashvilleHousing
Where PropertyAddress is NULL


select *
from housing_data.dbo.NashvilleHousing
Where PropertyAddress is NULL


select *
from housing_data.dbo.NashvilleHousing
Order by parcelID


--- We noticed ParcelID and Property address are the sameor related, as such we can use the corresponding Property address from any complete parcelID to fill the the NULL

-- Doing a self join 


Select ab.ParcelID, ab.PropertyAddress, cd.ParcelID, cd.PropertyAddress, ISNULL(ab.PropertyAddress, cd.PropertyAddress)
From housing_data.dbo.NashvilleHousing ab
JOIN housing_data.dbo.NashvilleHousing cd
	ON ab.ParcelID = cd.ParcelID
	AND ab.[UniqueID] <> cd.[UniqueID]
	Where ab.PropertyAddress is NULL


UPDATE ab
SET PropertyAddress = ISNULL(ab.PropertyAddress, cd.PropertyAddress)
From housing_data.dbo.NashvilleHousing ab
JOIN housing_data.dbo.NashvilleHousing cd
	ON ab.ParcelID = cd.ParcelID
	AND ab.[UniqueID] <> cd.[UniqueID]
	Where ab.PropertyAddress is NULL


	-- To check for update

select *
from housing_data.dbo.NashvilleHousing
where PropertyAddress is null



--Seperating address into different column (Address, city and state)



-- Property Address


select PropertyAddress
from housing_data.dbo.NashvilleHousing


select 
SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress)-1) as Address
, SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress)+1, LEN (PropertyAddress))as Address
from housing_data.dbo.NashvilleHousing



-- Updating new columns


ALTER TABLE NashvilleHousing
Add PropertySplitAddress Nvarchar (255);

UPDATE NashvilleHousing
SET PropertySplitAddress  = SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress)-1)

ALTER TABLE NashvilleHousing
Add PropertySplitcity Nvarchar (255);

UPDATE NashvilleHousing
SET PropertySplitcity  = SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress)+1, LEN (PropertyAddress))







-- Spliting Owner Address

Select OwnerAddress
from housing_data.dbo.NashvilleHousing


Select
PARSENAME(REPLACE (OwnerAddress, ',', '.'), 3)
, PARSENAME(REPLACE (OwnerAddress, ',', '.'), 2)
, PARSENAME(REPLACE (OwnerAddress, ',', '.'), 1)
from housing_data.dbo.NashvilleHousing



-- Updating the table


ALTER TABLE NashvilleHousing
Add OwnerSplitAddress Nvarchar (255);

UPDATE NashvilleHousing
SET OwnerSplitAddress  = PARSENAME(REPLACE (OwnerAddress, ',', '.'), 3)


ALTER TABLE NashvilleHousing
Add OwnerSplitCity Nvarchar (255);

UPDATE NashvilleHousing
SET OwnerSplitCity  = PARSENAME(REPLACE (OwnerAddress, ',', '.'), 2)

ALTER TABLE NashvilleHousing
Add OwnerSplitState Nvarchar (255);

UPDATE NashvilleHousing
SET OwnerSplitState  = PARSENAME(REPLACE (OwnerAddress, ',', '.'), 1)



--Change SoldAsVacant as from Y and N to Yes and No

Select Distinct (SoldAsVacant)
From housing_data.dbo.NashvilleHousing



Select SoldAsVacant,
CASE 
When SoldAsVacant = 'Y' THEN 'Yes'
When SoldAsVacant = 'N' THEN 'No'
ELSE SoldAsVacant
End
From housing_data.dbo.NashvilleHousing



UPDATE NashvilleHousing
SET SoldAsVacant = CASE When SoldAsVacant = 'Y' THEN 'Yes'
When SoldAsVacant = 'N' THEN 'No'
ELSE SoldAsVacant
End




--Remove Duplicates and Remove unused column

WITH RowNumCTE AS(
Select*,
	ROW_NUMBER() OVER (
	PARTITION BY ParcelID,
			PropertyAddress,
			SalePrice,
			SaleDate,
			LegalReference
			ORDER BY 
				UniqueID
				) row_num

From housing_data.dbo.NashvilleHousing
)
DELETE
From RowNumCTE
Where row_num > 1































