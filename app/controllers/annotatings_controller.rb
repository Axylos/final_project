class AnnotatingsController <ApplicationController


  def create
    if doc_params[:ref_text]
      ensure_current_is_author
      add_reference
    else
      add_annotation
    end
  end

  def new
    @docs = Document.all
    @document = Document.find(params[:document_id])
  end

  def destroy
    @annotating = Annotating.find(params[:id])
    annotation = @annotating.annotation
    if current_user = @annotating.annotation.author
      if @annotating.destroy
        add_notice("Reference successfully destroyed!")
        redirect_to document_url(annotation)
      else
        add_error(@annotating.errors.full_messages)
        redirect_to document_url(annotation)
      end
    else
      add_error("You can't destroy an annotation that isn't yours!")
      redirect_to document_url(annotation)
    end
  end


  private

  def doc_params
    params.require(:annotating).permit(:body, :source_text, :title, :ref_text)
  end

  def annotating_created
    ActiveRecord::Base.transaction do
      @document.save
      @document.references.create(
              source_document_id: params[:document_id],
              source_text: doc_params[:source_text].split
            )
    end
  end

  def add_reference
    @annotating = Annotating.new(
      source_document_id: doc_params[:ref_text],
      annotation_id: params[:document_id],
      source_text: doc_params[:source_text].split
    )

    if @annotating.save
      add_notice("#{@annotating.text_selection} saved from
                          #{@annotating.source_document.title}")
    else
      add_error(@annotating.errors.full_messages)
    end
    redirect_to new_document_annotating_url(params[:document_id])
  end

  def add_annotation
    @document = current_user.documents.new(
          body: doc_params[:body],
          title: doc_params[:title]
        )

    if annotating_created
      redirect_to document_url(@document)
    else
      add_error(@document.errors.full_messages)
      add_error(@annotating.errors.full_messages) if @annotating
      redirect_to document_url(params[:document_id])
    end
  end

  def ensure_current_is_author
    author = Document.find(params[:document_id]).author
    unless author == current_user
      add_error("You must be the author of a document to add references!")
      redirect_to root_path
    end
  end

end