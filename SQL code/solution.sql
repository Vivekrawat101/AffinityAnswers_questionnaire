--------------------------------------------------------------------------
-- Question 1.
-- How many types of tigers can be found in the taxonomy table of the dataset? 
-- What is the "ncbi_id" of the Sumatran Tiger? 
--------------------------------------------------------------------------

Answer: 8 types of tigers

Select * from taxonomy where species LIKE
'%Panthera_tigris%' OR tree_display_name LIKE '%Panthera_tigris%';

ncbi_id of sumatran tiger is 9695


--------------------------------------------------------------------------
-- Question 2.
-- Find all the columns that can be used to connect the tables in the given database.
--------------------------------------------------------------------------
Answer: Since primary keys and foreign keys are required to connect tables , I am listing
down the primary keys and primary keys present in Rfam database.
--------------------------------------------------------------------------
Primary Keys:
--------------------------------------------------------------------------
Table Name                  Column Name                Data Type
author                      author_id                  int
clan                        clan_acc                   varchar
clan_membership              rfam_acc                   varchar
db_version                  rfam_release               double
dead_clan                   clan_acc                   varchar
dead_family                 rfam_acc                   varchar
ensembl_names               insdc                      varchar
family                      rfam_acc                   varchar
genome                      upid                       varchar
genome_temp                 upid                       varchar
keywords                    rfam_acc                   varchar
literature_reference         pmid                       int
motif                       motif_acc                  varchar
motif_old                   motif_acc                  varchar
pdb                         pdb_id                     varchar
pdb_rfam_reg                auto_pdb_reg               int
pdb_sequence                pdb_seq                    varchar
refseq                      refseq_acc                 varchar
rfamseq                     rfamseq_acc                varchar
rfamseq_temp                rfamseq_acc                varchar
rscape_annotations           rfam_acc                   varchar
taxonomic_tree              ncbi_code                  int
taxonomy                    ncbi_id                    int
version                     rfam_release               double
wikitext                    auto_wiki                  int
_annotated_file             rfam_acc                   varchar
_overlap                    auto_overlap               int
--------------------------------------------------------------------------
Foreign Keys:
--------------------------------------------------------------------------
Table Name                       Foreign Key                 Referenced Table Name
_family_file                      rfam_acc                   family
_overlap_membership               rfam_acc                   family
_overlap                          auto_overlap              _overlap
_post_process                     rfam_acc                   family
alignment_and_tree                rfam_acc                   family
clan_database_link                clan_acc                   clan
clan_literature_reference          clan_acc                   clan
clan_literature_reference          pmid                      literature_reference
clan_membership                    clan_acc                   clan
clan_membership                    rfam_acc                   family
database_link                     rfam_acc                   family
family                            auto_wiki                  wikitext
family_literature_reference        rfam_acc                   family
family_literature_reference        pmid                      literature_reference
family_long                       rfam_acc                   family
family_ncbi                        ncbi_id                   taxonomy
family_ncbi                        rfam_acc                   family
features                          rfamseq_acc                rfamseq
full_region                       rfam_acc                   family
full_region                       rfamseq_acc                rfamseq
html_alignment                     rfam_acc                   family
matches_and_fasta                  rfam_acc                   family
motif_database_link                motif_acc                  motif
motif_family_stats                 motif_acc                  motif_old
motif_family_stats                 rfam_acc                   family
motif_file                         motif_acc                  motif
motif_literature                   motif_acc                  motif_old
motif_literature                   pmid                      literature_reference
motif_matches                      motif_acc                  motif_old
motif_matches                      rfam_acc                   family
motif_matches                      rfamseq_acc                rfamseq
motif_pdb                         motif_acc                  motif_old
motif_ss_image                    rfam_acc                   family
motif_ss_image                    motif_acc                  motif_old
pdb_rfam_reg                      rfam_acc                   family
pdb_rfam_reg                      pdb_id                    pdb
pdb_rfam_reg                      pdb_seq                   pdb_sequence
pdb_rfam_reg                      rfamseq_acc                rfamseq
pdb_sequence                      pdb_id                    pdb
processed_data                    rfam_acc                   family
pseudoknot                        rfam_acc                   family
refseq_full_region                 rfam_acc                   family
refseq_full_region                 refseq_acc                 refseq
rfamseq                            ncbi_id                   taxonomy
secondary_structure_image         rfam_acc                   family
seed_region                        rfam_acc                   family
seed_region                        rfamseq_acc                rfamseq
sunburst                           rfam_acc                   family
--------------------------------------------------------------------------


--------------------------------------------------------------------------
-- Question 3.
-- Which type of rice has the longest DNA sequence? 
--------------------------------------------------------------------------
Answer : 
rice species with longest dna sequence: 'Oryza sativa Indica Group'
 
SELECT 
    r.ncbi_id,
    t.species,
    MAX(r.length) AS DNA_sequence,
    r.description
FROM
    taxonomy t
        LEFT JOIN
    rfamseq r ON t.ncbi_id = r.ncbi_id
WHERE
    t.species IN ('Oryza glaberrima x Oryza sativa' , 'Oryza rufipogon x Oryza sativa',
        'Oryza sativa (Indica Group) x Oryza nivara',
        'Oryza sativa (rice)',
        'Oryza sativa endornavirus',
        'Oryza sativa endornavirus (isolate Japan)',
        'Oryza sativa Indica Group',
        'Oryza sativa Japonica Group',
        'Oryza sativa x Oryza glaberrima')
GROUP BY t.species , r.ncbi_id
ORDER BY MAX(r.length) DESC
LIMIT 1; 


--------------------------------------------------------------------------
--Question 4
-- We want to paginate a list of the family names and their longest DNA sequence lengths  
--(in descending order of length) where only families that have DNA sequence lengths greater than 1,000,000 are included. 
--Give a query that will return the 9th page when there are 15 results per page.
--------------------------------------------------------------------------
Answer :

select t.ncbi_id, t.species , max(r.length) as DNA_sequence  from taxonomy t 
left join
rfamseq r on t.ncbi_id = r.ncbi_id 
group by t.species having max(r.length) > 100000 ORDER BY DNA_sequence DESC
LIMIT 15 OFFSET 120;
